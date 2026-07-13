import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:facepass/core/constants/app_colors.dart';
import 'package:facepass/core/router/router_app.dart';
import 'package:facepass/features/face_verification/presentasion/blocs/attendance/attendance_bloc.dart';
import 'package:facepass/features/face_verification/presentasion/blocs/recognized_faces/recognized_faces_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/camera_utils.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/face_embedding.dart';
import '../blocs/recognizing_face/recognizing_face_bloc.dart';
import '../cubit/camera_process_cubit.dart';
import '../widgets/buttom_pannel_cus.dart';
import '../widgets/camera_cus.dart';
import '../widgets/date_chip_cus.dart';
import '../widgets/face_oval_cus.dart';
import '../widgets/live_chip_cus.dart';

/* 
 * Lớp dịch vụ quản lý mô hình TFLite FaceNet 
 * Khởi tạo Background Isolate Worker để duy trì mô hình, tránh việc phải load lại nhiều lần
 */
class FaceNetService {
  Uint8List? modelBytes;
  bool _isLoaded = false;

  Future<void> loadModel() async {
    try {
      final byteData = await rootBundle.load('assets/models/facenet.tflite');
      modelBytes = byteData.buffer.asUint8List();
      await FaceRecognitionWorker.init(modelBytes!, RootIsolateToken.instance!);
      _isLoaded = true;
    } catch (e) {
      debugPrint('Model load failed: $e');
    }
  }

  bool get isLoaded => _isLoaded;
}

class CameraScreen extends StatefulWidget {
  final int index;
  final User user;
  const CameraScreen({super.key, required this.index, required this.user});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  final _faceNetService = FaceNetService();

  @override
  void initState() {
    //giả lập đã call trước
    // context.read<UserBloc>().add(GetUserByIdEvent(id: widget.user.id));
    context.read<RecognizingFaceBloc>().add(InitProcessFaceEvent());
    _initializeAll();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeAll() async {
    await _initializeCamera();
    await _faceNetService.loadModel();
    if (!mounted) return;
    context.read<CameraProcessCubit>().setCameraReady(true);
  }

  //khởi tạo camera và xử lý lỗi nếu có
  Future<void> _initializeCamera() async {
    try {
      // Xử lý ảnh cuối vào để phát hiện khuôn mặt
      final cameras = await availableCameras();
      final front = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first, // fallback
      );
      _controller = CameraController(
        front,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller!.initialize();

      setState(() {});
    } catch (e) {
      debugPrint('Lỗi khơi tạo camera: $e');
    }
  }

  /*
   * Gửi yêu cầu trích xuất đặc trưng khuôn mặt (embedding) từ một bức ảnh 
   * Ảnh sẽ được gửi vào Background Isolate để xử lý mà không làm giật UI
   */
  Future<List<double>?> _processFaceRecognition(String path) async {
    if (!_faceNetService.isLoaded) return null;
    return await FaceRecognitionWorker.process(path);
  }

  /*
   * Logic Đăng ký khuôn mặt mới (Vòng lặp lấy 5 góc độ khuôn mặt)
   * UI sẽ gọi liên tiếp hàm chụp ảnh và gửi vào BLoC
   */
  void _scanFace() async {
    final cameraCubit = context.read<CameraProcessCubit>();
    final recognizingBloc = context.read<RecognizingFaceBloc>();
    // final userBloc = context.read<UserBloc>();

    if (cameraCubit.state['isProcessing'] ||
        !cameraCubit.state['isCameraReady']) {
      return;
    }

    try {
      cameraCubit.setProcessing(true);

      recognizingBloc.add(InitProcessFaceEvent());

      recognizingBloc.add(CreateTempFaceEmbedding(userId: widget.user.id));

      int count = 0;
      int countFaceFailed = 0;
      String? faceImageBase64;

      while (count < 5) {
        debugPrint('Bắt đầu vòng lặp: $count');

        final image = await _controller!.takePicture();
        debugPrint('Đã chụp ảnh');
        final embedding = await _processFaceRecognition(image.path);

        if (embedding == null) {
          countFaceFailed++;
          if (countFaceFailed == 3) {
            recognizingBloc.add(StopVerifyingEvent(message: 'Đã dừng xử lý'));
            return;
          }
          // recognizingBloc.add(
          //   CheckSimilarityEvent(message: 'Không phát hiện khuôn mặt'),
          // );
          continue;
        }
        faceImageBase64 ??= base64Encode(await image.readAsBytes());
        recognizingBloc.add(
          ProcessingFaceEvent(newEmbedding: embedding, index: count + 1),
        );

        // Đợi một chút để UI cập nhật trạng thái mới nhất từ BLoC
        await Future.delayed(const Duration(milliseconds: 100));

        final currentState = recognizingBloc.state;
        if (currentState is RecognizingFaceProcessingErrol ||
            currentState is RecognizingFaceFailed) {
          return;
        }

        debugPrint('Vòng lặp thứ: $count');
        count++;
      }

      //lưu lên database
      if (!mounted) return;
      context.read<RecognizedFacesBloc>().add(AddRecognizedFaceEvent(
          faceEmbedding: recognizingBloc.state.maybeWhen(
              success: (embedding, message) =>
                  embedding.copyWith(imageBase64: faceImageBase64),
              orElse: () => FaceEmbedding(
                  vector1: [],
                  vector2: [],
                  vector3: [],
                  vector4: [],
                  vector5: [],
                  imageBase64: faceImageBase64,
                  id: '',
                  userId: '',
                  registeredAt: DateTime.now()))));
    } catch (e) {
      debugPrint('lỗi : $e');
    } finally {
      if (mounted) {
        cameraCubit.setProcessing(false);
        cameraCubit.setCameraReady(true);
      }
    }
  }

  /*
   * Logic so sánh khuôn mặt hiện tại với cơ sở dữ liệu đã đăng ký
   * Nếu trùng khớp (độ tương đồng > 0.8), tuỳ theo index:
   *  - index = 1: Báo lỗi "Khuôn mặt đã tồn tại" (dành cho luồng đăng ký)
   *  - index = 2: Gửi sự kiện CheckInOutEvent để chấm công
   */
  void _checkSimilarity(int? index) async {
    final recognizedFacesBloc = context.read<RecognizedFacesBloc>();
    final recognizedFaces = recognizedFacesBloc.state.maybeWhen(
      hasData: (faces) => faces,
      orElse: () => <FaceEmbedding>[],
    );
    if (recognizedFaces.isEmpty) {
      if (index == 1) {
        _scanFace();
        return;
      }
    }
    if (!mounted) return;
    context.read<RecognizingFaceBloc>().add(
          ProcessingInitEvent(message: 'Đang bắt đầu nhận diện khuôn mặt'),
        );

    final image = await _controller!.takePicture();
    final newEmbedding = await _processFaceRecognition(image.path);

    if (!mounted) return;
    if (newEmbedding == null || newEmbedding.isEmpty) {
      context.read<RecognizingFaceBloc>().add(
            CheckSimilarityEvent(
              message: 'Không phát hiện khuôn mặt, vui lòng thử lại',
            ),
          );
      return;
    }
    FaceEmbedding? bestFace;
    double bestSimilarity = 0;
    for (var face in recognizedFaces) {
      final similarity = CameraUtils.cosineSimilarity(
        newEmbedding,
        face.vector1,
      );
      if (similarity > bestSimilarity) {
        bestSimilarity = similarity;
        bestFace = face;
      }
    }

    if (bestFace != null && bestSimilarity > 0.8) {
      if (index == 1) {
        context.read<RecognizingFaceBloc>().add(
              CheckSimilarityEvent(
                message: 'Khuôn mặt đã tồn tại, vui lòng thử lại',
              ),
            );
        return;
      }

      context.read<AttendanceBloc>().add(
            CheckInOutEvent(
                userId: bestFace.userId,
                userName: widget.user.name,
                similarity: bestSimilarity,
                imageBase64: base64Encode(await image.readAsBytes())),
          );
      return;
    } else {
      if (index == 1) {
        _scanFace();
        return;
      }
      context.read<RecognizingFaceBloc>().add(
            CheckSimilarityEvent(
              message: 'Khuôn mặt không khớp, vui lòng thử lại',
            ),
          );
    }
  }

  ElevatedButton elevatedButton({
    required Map<String, dynamic> cameraState,
    required VoidCallback? onPressed,
    required String text,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade600,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  BlocBuilder<RecognizingFaceBloc, RecognizingFaceState> get recognizingBloc =>
      BlocBuilder<RecognizingFaceBloc, RecognizingFaceState>(
        buildWhen: (previous, current) {
          if (current is RecognizingFaceProcessingUpdate) {
            debugPrint("DEBUG: ${current.embedding.toString()}");
          }
          return previous != current;
        },
        builder: (context, state) {
          return state.maybeWhen(
            initial: (messge) => output(
                messge ?? 'Vui lòng cho khuôn mặt vào khung để nhận diện'),
            processingErrol: (message) => output(message),
            processingUpdate: (embedding, message) {
              debugPrint(
                '${embedding.vector1.length} ${embedding.vector2.length} ${embedding.vector3.length} ${embedding.vector4.length} ${embedding.vector5.length}',
              );
              return output(message ?? 'Vui lòng đợi, đang xử lý...');
            },
            similaritySuccess: (embedding, message) =>
                output(message ?? 'Đã nhận diện khuôn mặt thành công'),
            success: (embedding, message) => output(message!),
            failed: (message) => output(message),
            processing: (message) => output(message),
            orElse: () => output('No data'),
          );
        },
      );
  Widget buildListener({required Widget child}) {
    return BlocListener<AttendanceBloc, AttendanceState>(
      listener: (context, state) {
        state.when((data, status, message) {
          switch (status) {
            case AttendanceStateStatus.success:
              context.read<RecognizingFaceBloc>().add(
                    CheckSimilarityEvent(
                        message: message ?? 'Chấm công thành công'),
                  );
              break;
            case AttendanceStateStatus.error:
              context.read<RecognizingFaceBloc>().add(
                    CheckSimilarityEvent(
                        message: message ?? 'Chấm công thất bại'),
                  );
              break;
            case AttendanceStateStatus.loading:
              // Có thể hiển thị loading indicator nếu cần
              break;
            case AttendanceStateStatus.initial:
              break;
          }
        });
      },
      child: BlocListener<RecognizedFacesBloc, RecognizedFacesState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (embedding, message) {
              context
                  .read<RecognizedFacesBloc>()
                  .add(LoadRecognizedFacesEvent());
              context.goNamed(homeRouteName);
            },
            orElse: () {},
          );
        },
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isIndex1 = widget.index == 1;
    return buildListener(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: isIndex1 ? null : 0,
          leading: isIndex1
              ? null
              : IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    context.pop();
                  },
                ),
          automaticallyImplyLeading: false,
          title: Text(
            widget.index == 1 ? 'Đăng ký khuôn mặt' : 'Chấm công',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.primary,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              // Camera full screen
              Positioned.fill(child: CameraCus(controller: _controller)),

              // Dark gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                      stops: const [0, 0.2, 0.6, 1],
                    ),
                  ),
                ),
              ),

              // Top bar
              Positioned(
                top: 12,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [DateChipCus(), LiveChipCus()],
                ),
              ),

              // Oval frame + scan line
              Center(child: FaceOvalCus()),

              // Bottom panel
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ButtomPannelCus(
                  index: widget.index,
                  userId: widget.user.id,
                  recognizingBloc: recognizingBloc,
                  onScan: () => _checkSimilarity(1),
                  onCheck: () => _checkSimilarity(null),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget output(String message) =>
      Text(message, style: const TextStyle(color: Colors.white70));
}

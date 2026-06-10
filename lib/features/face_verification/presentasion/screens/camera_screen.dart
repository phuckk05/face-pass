import 'dart:async';

import 'package:camera/camera.dart';
import 'package:facepass/features/face_verification/domain/entities/face_embedding%20.dart';
import 'package:facepass/features/face_verification/presentasion/blocs/recognized_faces/recognized_faces_bloc.dart';
import 'package:facepass/features/face_verification/presentasion/blocs/register_user/user_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../../core/utils/camera_utils.dart';
import '../blocs/recognizing_face/recognizing_face_bloc.dart';
import '../cubit/camera_process_cubit.dart';
import '../widgets/buttom_pannel_cus.dart';
import '../widgets/camera_cus.dart';
import '../widgets/date_chip_cus.dart';
import '../widgets/face_oval_cus.dart';
import '../widgets/live_chip_cus.dart';

class FaceNetService {
  Interpreter? interpreter;
  Uint8List? modelBytes;
  bool _isLoaded = false;

  Future<void> loadModel() async {
    try {
      final byteData = await rootBundle.load('assets/models/facenet.tflite');
      modelBytes = byteData.buffer.asUint8List();
      interpreter = Interpreter.fromBuffer(modelBytes!);
      _isLoaded = true;
    } catch (e) {
      debugPrint('Model load failed: $e');
    }
  }

  bool get isLoaded => _isLoaded;
}

class CameraScreen extends StatefulWidget {
  final int index;
  const CameraScreen({super.key, required this.index});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  final _faceNetService = FaceNetService();

  @override
  void initState() {
    //giả lập đã call trước
    context.read<UserBloc>().add(GetUserByIdEvent(id: "1780664304466"));

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

  Future<List<double>?> _processFaceRecognition(String path) async {
    if (_faceNetService.modelBytes == null) return null;

    return compute(CameraUtils.recognizeIsolate, {
      'path': path,
      'modelBytes': _faceNetService.modelBytes!,
      'rootIsolateToken': RootIsolateToken.instance!,
    });
  }

  // _scanFace gọn lại
  void _scanFace() async {
    final cameraCubit = context.read<CameraProcessCubit>();
    final recognizingBloc = context.read<RecognizingFaceBloc>();
    final stream = recognizingBloc.stream;
    // final userBloc = context.read<UserBloc>();

    if (cameraCubit.state['isProcessing'] ||
        !cameraCubit.state['isCameraReady']) {
      return;
    }

    try {
      cameraCubit.setProcessing(true);

      recognizingBloc.add(InitProcessFaceEvent());

      recognizingBloc.add(CreateTempFaceEmbedding(userId: '1780664304466'));

      int count = 0;
      int countFaceFailed = 0;

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
        // recognizingBloc.add(
        //   CheckSimilarityEvent(message: 'Đang xử lý khuôn mặt'),
        // );

        recognizingBloc.add(
          ProcessingFaceEvent(newEmbedding: embedding, index: count + 1),
        );

        final result = await stream.firstWhere(
          (state) =>
              state is RecognizingFaceProcessingErrol ||
              state is RecognizingFaceProcessingUpdate ||
              state is RecognizingFaceSuccess ||
              state is RecognizingFaceFailed,
        );

        if (result is RecognizingFaceProcessingErrol ||
            result is RecognizingFaceFailed) {
          return;
        }
        debugPrint('Vòng lặp thứ: $count');
        count++;
      }
    } catch (e) {
      debugPrint('lỗi : $e');
    } finally {
      if (mounted) {
        cameraCubit.setProcessing(false);
        cameraCubit.setCameraReady(true);
      }
    }
  }

  void _checkSimilarity() async {
    final recognizedFacesBloc = context.read<RecognizedFacesBloc>();
    final recognizedFaces = recognizedFacesBloc.state.maybeWhen(
      hasData: (faces) => faces,
      orElse: () => <List<FaceEmbedding>>[],
    );
    if (recognizedFaces.isEmpty) {
      return;
    }
    context.read<RecognizingFaceBloc>().add(
      CheckSimilarityEvent(message: 'Đang kiểm tra độ tương đồng...'),
    );

    final image = await _controller!.takePicture();
    final newEmbedding = await _processFaceRecognition(image.path);

    if (newEmbedding == null || newEmbedding.isEmpty) {
      return;
    }
    for (var face in recognizedFaces as List<FaceEmbedding>) {
      if (CameraUtils.cosineSimilarity(newEmbedding, face.vector1) > 0.8) {
        context.read<RecognizingFaceBloc>().add(
          SimilaritySuccessEvent(
            embedding: face,
            message: 'Đã nhận diện khuôn mặt thành công',
          ),
        );
        return;
      }
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

  BlocBuilder<RecognizingFaceBloc, RecognizingFaceState>
  get recognizingBloc => BlocBuilder<RecognizingFaceBloc, RecognizingFaceState>(
    buildWhen: (previous, current) {
      if (current is RecognizingFaceProcessingUpdate) {
        debugPrint("DEBUG: ${current.embedding.toString()}");
      }
      return previous != current;
    },
    builder: (context, state) {
      return state.maybeWhen(
        initial: (messge) =>
            output(messge ?? 'Vui lòng cho khuôn mặt vào khung để nhận diện'),
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
    return BlocListener<RecognizingFaceBloc, RecognizingFaceState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (embedding, message) {
            context.read<RecognizedFacesBloc>().add(
              AddRecognizedFaceEvent(embedding),
            );
          },
          orElse: () {},
        );
      },
      child: BlocListener<RecognizedFacesBloc, RecognizedFacesState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (embedding, message) {
              // context.read<RecognizingFaceBloc>().add(
              //   CheckSimilarityEvent(message: 'Đã thêm khuôn mặt thành công'),
              // );
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
    return buildListener(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          title: const Text(
            'Đăng ký khuôn mặt',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF2d6a4f),
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
                  recognizingBloc: recognizingBloc,
                  onScan: _scanFace,
                  onCheck: _checkSimilarity,
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

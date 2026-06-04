import 'dart:async';

import 'package:camera/camera.dart';
import 'package:facepass/features/face_verification/presentasion/blocs/recognized_faces/recognized_faces_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../../core/utils/camera_utils.dart';
import '../blocs/recognizing_face/recognizing_face_bloc.dart';
import '../cubit/camera_process_cubit.dart';
import '../widgets/camera_cus.dart';

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
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  final _faceNetService = FaceNetService();

  @override
  void initState() {
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
    final recognizedFacesBloc = context.read<RecognizedFacesBloc>();
    final cameraState = context.read<CameraProcessCubit>();

    if (cameraState.state['isProcessing'] ||
        !cameraState.state['isCameraReady'])
      return;

    cameraState.setProcessing(true);
    //stream
    try {
      final image = await _controller!.takePicture();
      final embedding = await _processFaceRecognition(image.path);
      if (embedding != null && embedding.isNotEmpty) {
        recognizedFacesBloc.add(AddRecognizedFaceEvent(embedding));
      }
    } finally {
      if (mounted) {
        cameraState.setProcessing(false);
        cameraState.setCameraReady(true);
      }
    }
  }

  // Stream<StreamController<CameraImage>> _streamImage() async* {
  //   _controller!.startImageStream((CameraImage image) async {
  //     await Future.delayed(const Duration(seconds: 1));
  //     yield image;
  //   });
  // }

  void _checkSimilarity() async {
    final recognizedFacesBloc = context.read<RecognizedFacesBloc>();
    final recognizedFaces = recognizedFacesBloc.state.maybeWhen(
      hasData: (faces) => faces,
      orElse: () => <List<double>>[],
    );
    if (recognizedFaces.isEmpty) {
      debugPrint('No recognized faces to compare.');
      return;
    }
    context.read<RecognizingFaceBloc>().add(InitProcessFaceEvent());

    final image = await _controller!.takePicture();
    final newEmbedding = await _processFaceRecognition(image.path);

    if (newEmbedding == null || newEmbedding.isEmpty) {
      debugPrint('No face detected for similarity check.');
      return;
    }
    context.read<RecognizingFaceBloc>().add(
      ProcessingFaceEvent(newEmbedding: newEmbedding, faces: recognizedFaces),
    );
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

  final output = (String text) => AnimatedSlide(
    duration: const Duration(milliseconds: 300),
    offset: text.isEmpty ? const Offset(0, -1) : Offset.zero,
    curve: Curves.easeInOut,
    child: Align(alignment: Alignment.centerLeft, child: Text('Output: $text')),
  );

  BlocBuilder<RecognizingFaceBloc, RecognizingFaceState> get recognizingBloc =>
      BlocBuilder<RecognizingFaceBloc, RecognizingFaceState>(
        builder: (context, state) {
          return state.maybeWhen(
            initial: (messge) => output(
              messge ?? 'Vui lòng cho khuôn mặt vào khung để nhận diện',
            ),
            success: (embedding, message) => output(message!),
            failed: (message) => output(message),
            processing: (message) => output(message),
            orElse: () => output('No data'),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Camera')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 7, child: CameraCus(controller: _controller)),
            SizedBox(height: 20),
            Expanded(
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocBuilder<CameraProcessCubit, Map<String, dynamic>>(
                    builder: (context, cameraState) {
                      return elevatedButton(
                        cameraState: cameraState,
                        onPressed:
                            cameraState['isProcessing'] ||
                                !cameraState['isCameraReady']
                            ? null
                            : _scanFace,
                        text: 'Scan Face',
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            recognizingBloc,
            SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: _checkSimilarity,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Check Similarity',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

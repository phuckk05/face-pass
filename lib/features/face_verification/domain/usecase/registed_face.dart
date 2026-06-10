import 'package:facepass/features/face_verification/domain/entities/face_embedding%20.dart';
import 'package:facepass/features/face_verification/domain/repositories/recognized_repository.dart';

class RegistedFace {
  final RecognizedRepository recognizedRepository;
  RegistedFace({required this.recognizedRepository});

  Future<List<FaceEmbedding>> callGetRegistedFaces() async {
    return await recognizedRepository.getRecognizedFaces();
  }
}

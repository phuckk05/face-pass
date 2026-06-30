import 'package:facepass/core/errors/failrue.dart';
import 'package:facepass/features/face_verification/domain/entities/face_embedding.dart';
import 'package:facepass/features/face_verification/domain/repositories/recognized_repository.dart';
import 'package:fpdart/fpdart.dart';

class RegistedFace {
  final RecognizedRepository recognizedRepository;
  RegistedFace({required this.recognizedRepository});

  Future<Either<Failure, List<FaceEmbedding>>> callGetRegistedFaces() async {
    return await recognizedRepository.getRecognizedFaces();
  }
}

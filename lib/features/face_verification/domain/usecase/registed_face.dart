import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failrue.dart';
import 'package:facepass/features/face_verification/domain/entities/face_embedding.dart';
import 'package:facepass/features/face_verification/domain/repositories/recognized_repository.dart';

class RegistedFace {
  final RecognizedRepository recognizedRepository;
  RegistedFace({required this.recognizedRepository});

  Future<Either<Failure, List<FaceEmbedding>>> callGetRegistedFaces() async {
    return await recognizedRepository.getRecognizedFaces();
  }

  //lấy face embedding của user đã đăng kí
  Future<Either<Failure, FaceEmbedding?>> callGetRegistedFaceByUserId(String userId) async {
    return await recognizedRepository.getRecognizedFaceByUserId(userId);
  }
}

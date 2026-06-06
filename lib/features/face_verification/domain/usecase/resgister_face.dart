import '../entities/face_embedding .dart';
import '../repositories/recognizing_repository.dart';

class RegisterFaceUseCase {
  final RecognizingRepository recognizingRepository;
  RegisterFaceUseCase({required this.recognizingRepository});

  //đăng kí khuôn mặt mới
  Future<bool> callRegisterFace(FaceEmbedding embedding) async {
    return await recognizingRepository.registerFaceEmbedding(embedding);
  }
}

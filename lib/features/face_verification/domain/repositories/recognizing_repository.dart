import '../entities/face_embedding .dart';
import '../entities/user.dart';

abstract class RecognizingRepository {
  Future<User> addUser(User user);
  Future<bool> registerFaceEmbedding(FaceEmbedding embedding);
  Future<User?> getUserById(String id);
}

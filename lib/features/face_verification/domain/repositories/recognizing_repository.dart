import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failrue.dart';
import '../entities/face_embedding.dart';
import '../entities/user.dart';

abstract class RecognizingRepository {
  Future<Either<Failure, User>> addUser(User user);
  Future<Either<Failure, bool>> registerFaceEmbedding(FaceEmbedding embedding);
  Future<Either<Failure, User>> getUserById(String id);
}

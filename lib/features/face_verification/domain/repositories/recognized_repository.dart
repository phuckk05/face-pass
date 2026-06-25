import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failrue.dart';
import '../entities/face_embedding.dart';

abstract class RecognizedRepository {
  Future<Either<Failure, List<FaceEmbedding>>> getRecognizedFaces();
  Future<Either<Failure, FaceEmbedding>> getRecognizedFaceByUserId(
      String userId);
}

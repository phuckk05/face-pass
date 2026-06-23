import '../entities/face_embedding.dart';

abstract class RecognizedRepository {
  Future<List<FaceEmbedding>> getRecognizedFaces();
  Future<FaceEmbedding?> getRecognizedFaceByUserId(String userId);
}

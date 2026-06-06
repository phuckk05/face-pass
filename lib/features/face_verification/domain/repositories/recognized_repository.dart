import '../entities/face_embedding .dart';

abstract class RecognizedRepository {
  Future<List<FaceEmbedding>> getRecognizedFaces();
}

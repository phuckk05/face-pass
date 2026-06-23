import '../../domain/entities/face_embedding.dart';
import '../../domain/repositories/recognized_repository.dart';
import '../datasource/remote/faces_datasource.dart';
import '../models/face_embedding_model.dart';

class RecognizedRepositoryImpl implements RecognizedRepository {
  final FacesRemoteDataSource remoteDataSource;
  RecognizedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<FaceEmbedding>> getRecognizedFaces() async {
    final List<FaceEmbeddingModel> models =
        await remoteDataSource.fetchRecognizedFaces();
    return models
        .map((model) => FaceEmbeddingModelX(model).toEntity())
        .toList();
  }

  @override
  Future<FaceEmbedding?> getRecognizedFaceByUserId(String userId) {
    final model = remoteDataSource.fetchRecognizedFaceByUserId(userId);
    return model.then((faceModel) {
      if (faceModel != null) {
        return FaceEmbeddingModelX(faceModel).toEntity();
      } else {
        return null;
      }
    });
  }
}

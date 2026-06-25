import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failrue.dart';
import '../../domain/entities/face_embedding.dart';
import '../../domain/repositories/recognized_repository.dart';
import '../datasource/remote/faces_datasource.dart';
import '../models/face_embedding_model.dart';

class RecognizedRepositoryImpl implements RecognizedRepository {
  final FacesRemoteDataSource remoteDataSource;
  RecognizedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<FaceEmbedding>>> getRecognizedFaces() async {
    final result = await remoteDataSource.fetchRecognizedFaces();
    return result.map((models) =>
        models.map((model) => FaceEmbeddingModelX(model).toEntity()).toList());
  }

  @override
  Future<Either<Failure, FaceEmbedding>> getRecognizedFaceByUserId(
      String userId) async {
    final result = await remoteDataSource.fetchRecognizedFaceByUserId(userId);
    return result.map((model) => FaceEmbeddingModelX(model).toEntity());
  }
}

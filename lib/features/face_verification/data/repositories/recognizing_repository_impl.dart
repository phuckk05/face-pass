import 'package:facepass/features/face_verification/data/datasource/remote/users_datasource.dart';
import 'package:facepass/features/face_verification/data/models/user_model.dart';
import 'package:facepass/features/face_verification/domain/entities/user.dart';
import 'package:facepass/features/face_verification/domain/repositories/recognizing_repository.dart';

import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failrue.dart';
import '../../domain/entities/face_embedding.dart';
import '../datasource/remote/faces_datasource.dart';
import '../models/face_embedding_model.dart';

class RecognizingRepositoryImpl implements RecognizingRepository {
  final FacesRemoteDataSource facesDatasource;
  final UserRemoteDatasource userDatasource;
  RecognizingRepositoryImpl({
    required this.facesDatasource,
    required this.userDatasource,
  });

  @override
  Future<Either<Failure, User>> addUser(User user) async {
    final userModel = UserX(user).toModel();
    final result = await userDatasource.addUser(userModel);
    return result.map((model) => UserModelX(model).toEntity());
  }

  @override
  Future<Either<Failure, bool>> registerFaceEmbedding(
      FaceEmbedding embedding) async {
    final faceEmbeddingModel = FaceEmbeddingX(embedding).toModel();
    return await facesDatasource.addRecognizedFace(faceEmbeddingModel);
  }

  @override
  Future<Either<Failure, User>> getUserById(String id) async {
    final result = await userDatasource.getUserById(id);
    return result.map((model) => UserModelX(model).toEntity());
  }
}

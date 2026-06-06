import 'package:facepass/features/face_verification/data/datasource/remote/users_datasource.dart';
import 'package:facepass/features/face_verification/data/models/user_model.dart';
import 'package:facepass/features/face_verification/domain/entities/user.dart';
import 'package:facepass/features/face_verification/domain/repositories/recognizing_repository.dart';

import '../../domain/entities/face_embedding .dart';
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
  Future<User> addUser(User user) async {
    final userModel = UserX(user).toModel();
    final addedUser = await userDatasource.addUser(userModel);
    final result = UserModelX(addedUser).toEntity();
    if (result.id == user.id) {
      return result;
    }
    throw Exception('Đã có lỗi xảy ra khi thêm thông tin người dùng');
  }

  @override
  Future<bool> registerFaceEmbedding(FaceEmbedding embedding) async {
    final faceEmbeddingModel = FaceEmbeddingX(embedding).toModel();
    return await facesDatasource.addRecognizedFace(faceEmbeddingModel);
  }

  @override
  Future<User?> getUserById(String id) async {
    final userModel = await userDatasource.getUserById(id);
    return UserModelX(userModel!).toEntity();
  }
}

import 'package:facepass/features/auth/data/data_source/users_datasource.dart';
import 'package:facepass/features/auth/data/models/user_model.dart';
import 'package:facepass/features/auth/domain/entities/user.dart';
import 'package:facepass/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserAuthRemoteDatasource userDatasource;
  UserRepositoryImpl({required this.userDatasource});
  @override
  Future<User> addUser(User user) {
    //convert User → UserModel
    final userModel = UserX(user).toModel();
    return userDatasource.addUser(userModel).then((addedUserModel) {
      return UserModelX(addedUserModel).toEntity();
    });
  }

  @override
  Future<User?> getUserByEmail(String email) {
    // TODO: implement getUserByEmail
    throw UnimplementedError();
  }

  @override
  Future<User?> getUserById(String id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<User?> login(String email, String password) {
    return userDatasource.loginUser(email, password).then((userModel) {
      if (userModel != null) {
        return UserModelX(userModel).toEntity();
      }
      return null;
    });
  }

  @override
  Future<bool> checkEmailExists(String email) =>
      userDatasource.checkEmailExists(email);

  @override
  Future<bool> updateUser(User user) {
    final userModel = UserX(user).toModel();
    return userDatasource.updateUser(userModel);
  }
}

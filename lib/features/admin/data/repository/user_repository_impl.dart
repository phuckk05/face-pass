import 'package:facepass/features/admin/data/data_source/users_datasource.dart';
import 'package:facepass/features/admin/data/models/user_model.dart';
import 'package:facepass/features/admin/domain/entities/user.dart';
import 'package:facepass/features/admin/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failrue.dart';

class UserAdminRepositoryImpl extends UserRepository {
  final UserAdminRemoteDatasource userDatasource;
  UserAdminRepositoryImpl({required this.userDatasource});

  @override
  Future<Either<Failure, bool>> deleteUser(String id) {
    return userDatasource.deleteUser(id);
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    final result = await userDatasource.getAllUsers();

    return result.map((users) {
      return users.map((model) => UserModelX(model).toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, bool>> updateUser(User user) {
    final userModel = UserX(user).toModel();
    return userDatasource.updateUser(userModel);
  }
}

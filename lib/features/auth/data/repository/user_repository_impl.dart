import 'package:facepass/features/auth/data/data_source/users_datasource.dart';
import 'package:facepass/features/auth/data/models/user_model.dart';
import 'package:facepass/features/auth/domain/entities/user.dart';
import 'package:facepass/features/auth/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failrue.dart';

class UserRepositoryImpl extends UserRepository {
  final UserAuthRemoteDatasource userDatasource;
  UserRepositoryImpl({required this.userDatasource});
  @override
  Future<Either<Failure, User>> addUser(User user) async {
    final userModel = UserX(user).toModel();
    final result = await userDatasource.addUser(userModel);
    return result.map((model) => UserModelX(model).toEntity());
  }

  // @override
  // Future<Either<Failure, User?>> getUserByEmail(String email) {
  //   // TODO: implement getUserByEmail
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, User?>> getUserById(String id) {
  //   // TODO: implement getUserById
  //   throw UnimplementedError();
  // }

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    final reslut = await userDatasource.loginUser(email, password);
    return reslut.map((model) => UserModelX(model).toEntity());
  }

  @override
  Future<Either<Failure, bool>> checkEmailExists(String email) async {
    return await userDatasource.checkEmailExists(email);
  }

  @override
  Future<Either<Failure, bool>> updateUser(User user) async {
    final userModel = UserX(user).toModel();
    return await userDatasource.updateUser(userModel);
  }
}

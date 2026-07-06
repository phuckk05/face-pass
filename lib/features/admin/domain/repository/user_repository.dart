import 'package:facepass/core/errors/failrue.dart';
import 'package:facepass/features/admin/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, bool>> updateUser(User user);
  Future<Either<Failure, bool>> deleteUser(String id);
}

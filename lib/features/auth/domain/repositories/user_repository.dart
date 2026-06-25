import 'package:facepass/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failrue.dart';

abstract class UserRepository {
  // Future<Either<Failure, User>> getUserByEmail(String email);
  Future<Either<Failure, User>> addUser(User user);
  // Future<Either<Failure, User>> getUserById(String id);
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, bool>> checkEmailExists(String email);
  Future<Either<Failure, bool>> updateUser(User user);
}

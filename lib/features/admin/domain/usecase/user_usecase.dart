import 'package:facepass/core/errors/failrue.dart';
import 'package:facepass/features/admin/domain/entities/user.dart';
import 'package:facepass/features/admin/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserAdminUsecase {
  final UserRepository userRepository;

  UserAdminUsecase({required this.userRepository});

  Future<Either<Failure, List<User>>> getAllUsers() async {
    return await userRepository.getAllUsers();
  }

  Future<Either<Failure, bool>> updateUser(User user) async {
    return await userRepository.updateUser(user);
  }

  Future<Either<Failure, bool>> deleteUser(String id) async {
    return await userRepository.deleteUser(id);
  }
}

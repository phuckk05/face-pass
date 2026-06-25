import 'package:facepass/features/auth/domain/entities/user.dart';
import 'package:facepass/features/auth/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failrue.dart';

class UserUsecase {
  final UserRepository userRepository;
  UserUsecase({required this.userRepository});

  //Login với email và password
  Future<Either<Failure, User>> loginUser(String email, String password) async {
    return await userRepository.login(email, password);
  }

  //Đăng ký người dùng mới
  Future<Either<Failure, User>> registerUser(User user) async {
    return await userRepository.addUser(user);
  }

  //kiểm tra email đã tồn tại hay chưa
  Future<Either<Failure, bool>> checkEmailExists(String email) async {
    return await userRepository.checkEmailExists(email);
  }

  //Cập nhật thông tin người dùng
  Future<Either<Failure, bool>> updateUser(User user) async {
    return await userRepository.updateUser(user);
  }
}

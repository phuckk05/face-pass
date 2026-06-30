import '../entities/user.dart';
import '../repositories/recognizing_repository.dart';

class RegisterUserUseCase {
  final RecognizingRepository recognizingRepository;
  RegisterUserUseCase({required this.recognizingRepository});

  //đăng kí người dùng mới
  Future<User> callRegisterUser(
    String? name,
    String? department,
    String? avatarUrl,
  ) async {
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name ?? 'Unknown',
      department: department ?? 'Unknown',
      avatarUrl: avatarUrl ?? '',
      createdAt: DateTime.now(),
    );
    return await recognizingRepository.addUser(user);
  }

  //lấy user theo id
  Future<User?> callGetUserById(String id) async {
    final user = await recognizingRepository.getUserById(id);
    return user;
  }
}

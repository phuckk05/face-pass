import 'package:facepass/features/auth/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getUserByEmail(String email);
  Future<User> addUser(User user);
  Future<User?> getUserById(String id);
  Future<User?> login(String email, String password);
  Future<bool> checkEmailExists(String email);
  Future<bool> updateUser(User user);
}

import 'package:facepass/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
    required String password,
    required String role,
    String? phoneNumber,
    String? department,
    String? avatarUrl,
    required DateTime createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  // Model → Entity
  User toEntity() => User(
        id: id,
        name: name,
        email: email,
        password: password,
        role: role,
        phoneNumber: phoneNumber,
        department: department,
        avatarUrl: avatarUrl,
        createdAt: createdAt,
      );
}

extension UserX on User {
  // Entity → Model
  UserModel toModel() => UserModel(
        id: id,
        name: name,
        email: email,
        password: password,
        role: role,
        phoneNumber: phoneNumber,
        department: department,
        avatarUrl: avatarUrl,
        createdAt: createdAt,
      );
}

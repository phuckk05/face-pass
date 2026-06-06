import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
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
    department: department,
    avatarUrl: avatarUrl,
    createdAt: createdAt,
  );
}

import 'dart:async';

import 'package:facepass/features/admin/data/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failrue.dart';

class UserAdminRemoteDatasource {
  final DatabaseReference db = FirebaseDatabase.instance.ref('users');

  //lấy tất cả user
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    //lấy tất cả user từ database, isDeleted = false
    try {
      final snapshot = await db.get().timeout(const Duration(seconds: 10));
      if (snapshot.exists) {
        final data = snapshot.value as Map<Object?, Object?>;
        final List<UserModel> users = [];

        for (var record in data.values) {
          try {
            final recordMap = (record as Map<Object?, Object?>).map(
              (key, value) => MapEntry(key.toString(), value),
            );
            if (recordMap['isDeleted'] == false ||
                recordMap['isDeleted'] == null) {
              users.add(UserModel.fromJson(recordMap));
            }
          } catch (e) {
            debugPrint('Lỗi khi parse bản ghi người dùng: $e');
          }
        }
        return Right(users);
      } else {
        return Right([]);
      }
    } on TimeoutException {
      debugPrint('Hết thời gian chờ khi lấy danh sách người dùng');
      return Left(TimeoutFailure());
    } catch (e) {
      debugPrint('Lỗi khi lấy danh sách người dùng: ${e.toString()}');
      return Left(
          ServerFailure('Lỗi khi lấy danh sách người dùng: ${e.toString()}'));
    }
  }

  //Xóa user bằng id
  Future<Either<Failure, bool>> deleteUser(String id) async {
    //cập nhật trường isDeleted thành true
    try {
      await db
          .child(id)
          .update({'isDeleted': true}).timeout(const Duration(seconds: 10));
      return Right(true);
    } on TimeoutException {
      debugPrint('Hết thời gian chờ khi xóa người dùng');
      return Left(TimeoutFailure());
    } catch (e) {
      debugPrint('Lỗi khi xóa người dùng: ${e.toString()}');
      return Left(ServerFailure('Lỗi khi xóa người dùng: ${e.toString()}'));
    }
  }

  //cập nhật thông tin người dùng
  Future<Either<Failure, bool>> updateUser(UserModel userData) async {
    try {
      await db
          .child(userData.id)
          .update(userData.toJson())
          .timeout(const Duration(seconds: 3));
      return Right(true);
    } on TimeoutException {
      debugPrint('Hết thời gian chờ khi cập nhật người dùng');
      return Left(TimeoutFailure());
    } catch (e) {
      debugPrint('Lỗi khi cập nhật người dùng: ${e.toString()}');
      return Left(
          ServerFailure('Lỗi khi cập nhật người dùng: ${e.toString()}'));
    }
  }
}

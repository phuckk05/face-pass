import 'dart:async';

import 'package:facepass/core/errors/failrue.dart';
import 'package:facepass/features/face_verification/data/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fpdart/fpdart.dart';

class UserRemoteDatasource {
  final DatabaseReference db = FirebaseDatabase.instance.ref('users');

  //thêm 1 user vào database
  Future<Either<Failure, UserModel>> addUser(UserModel userData) async {
    try {
      await db
          .child(userData.id)
          .set(userData.toJson())
          .timeout(const Duration(seconds: 10));
      return Right(userData);
    } on TimeoutException {
      return Left(const TimeoutFailure());
    } catch (e) {
      return Left(ServerFailure(
        'Đã có lỗi xảy ra khi thêm thông tin người dùng ${e.toString()}',
      ));
    }
  }

  //lấy user bằng id
  Future<Either<Failure, UserModel>> getUserById(String id) async {
    try {
      final snapshot =
          await db.child(id).get().timeout(const Duration(seconds: 10));
      if (snapshot.exists) {
        final data = snapshot.value as Map<Object?, Object?>;
        final mapData =
            data.map((key, value) => MapEntry(key.toString(), value));
        return Right(UserModel.fromJson(mapData));
      } else {
        return Left(const EmptyDataFailure());
      }
    } on TimeoutException {
      return Left(const TimeoutFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

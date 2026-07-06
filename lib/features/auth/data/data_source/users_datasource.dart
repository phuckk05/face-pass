import 'dart:async';

import 'package:facepass/features/auth/data/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failrue.dart';

class UserAuthRemoteDatasource {
  final DatabaseReference db = FirebaseDatabase.instance.ref('users');

  //thêm 1 user vào database
  Future<Either<Failure, UserModel>> addUser(UserModel userData) async {
    try {
      await db
          .child(userData.id)
          .set(userData.toJson())
          .timeout(const Duration(seconds: 3));
      return Right(userData);
    } on TimeoutException {
      debugPrint('Hết thời gian chờ khi thêm người dùng');
      return Left(TimeoutFailure());
    } catch (e) {
      debugPrint('Lỗi khi thêm người dùng: ${e.toString()}');
      return Left(ServerFailure('Lỗi khi thêm người dùng: ${e.toString()}'));
    }
  }

  //lấy user bằng id
  Future<Either<Failure, UserModel?>> getUserById(String id) async {
    try {
      final snapshot =
          await db.child(id).get().timeout(const Duration(seconds: 3));
      if (snapshot.exists) {
        final data = snapshot.value as Map<String, dynamic>;
        return Right(UserModel.fromJson(data));
      } else {
        return Left(EmptyDataFailure());
      }
    } on TimeoutException {
      debugPrint('Hết thời gian chờ khi lấy người dùng');
      return Left(TimeoutFailure());
    } catch (e) {
      debugPrint('Lỗi khi lấy người dùng: ${e.toString()}');
      return Left(ServerFailure('Lỗi khi lấy người dùng: ${e.toString()}'));
    }
  }

  //login user bằng email và password
  Future<Either<Failure, UserModel>> loginUser(
      String email, String password) async {
    try {
      final snapshot = await db
          .orderByChild('email')
          .equalTo(email)
          .get()
          .timeout(const Duration(seconds: 3));

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(
          snapshot.value as Map,
        );

        final userData = Map<String, dynamic>.from(
          data.values.first as Map,
        );
        if (userData['isDeleted'] == true) {
          return Left(ServerFailure('Tài khoản đã bị xóa.'));
        }

        if (userData['password'] == password) {
          return Right(UserModel.fromJson(userData));
        }
        return Left(InvalidDataFailure('Sai email hoặc mật khẩu.'));
      }

      return Left(InvalidDataFailure('Sai email hoặc mật khẩu.'));
    } on TimeoutException {
      debugPrint('Hết thời gian chờ khi đăng nhập');
      return Left(TimeoutFailure());
    } catch (e) {
      debugPrint('Lỗi đăng nhập: $e');
      return Left(ServerFailure('Lỗi khi đăng nhập: ${e.toString()}'));
    }
  }

  //Kiểm tra xem email đã tồn tại chưa
  Future<Either<Failure, bool>> checkEmailExists(String email) async {
    try {
      final snapshot = await db
          .orderByChild('email')
          .equalTo(email)
          .get()
          .timeout(const Duration(seconds: 3));

      return Right(snapshot.exists);
    } on TimeoutException {
      debugPrint('Hết thời gian chờ khi kiểm tra email');
      return Left(TimeoutFailure());
    } catch (e) {
      debugPrint('Lỗi khi kiểm tra email: $e');
      return Left(ServerFailure('Lỗi khi kiểm tra email: ${e.toString()}'));
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

import 'package:facepass/features/auth/data/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserAuthRemoteDatasource {
  final DatabaseReference db = FirebaseDatabase.instance.ref('users');

  //thêm 1 user vào database
  Future<UserModel> addUser(UserModel userData) async {
    try {
      await db.child(userData.id).set(userData.toJson());
      return userData;
    } catch (e) {
      throw Exception(
        'Đã có lỗi xảy ra khi thêm thông tin người dùng ${e.toString()}',
      );
    }
  }

  //lấy user bằng id
  Future<UserModel?> getUserById(String id) async {
    try {
      final snapshot = await db.child(id).get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<String, dynamic>;
        return UserModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Lỗi khi lấy người dùng: ${e.toString()}');
      return null;
    }
  }

  //login user bằng email và password
  Future<UserModel?> loginUser(String email, String password) async {
    try {
      final snapshot = await db.orderByChild('email').equalTo(email).get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(
          snapshot.value as Map,
        );

        final userData = Map<String, dynamic>.from(
          data.values.first as Map,
        );

        debugPrint('Dữ liệu người dùng: $userData');
        debugPrint('Mật khẩu nhập vào: $password');

        if (userData['password'] == password) {
          return UserModel.fromJson(userData);
        }
      }

      return null;
    } catch (e) {
      debugPrint('Lỗi đăng nhập: $e');
      return null;
    }
  }

  //Kiểm tra xem email đã tồn tại chưa
  Future<bool> checkEmailExists(String email) async {
    try {
      final snapshot = await db.orderByChild('email').equalTo(email).get();
      return snapshot.exists;
    } catch (e) {
      debugPrint('Lỗi kiểm tra email: ${e.toString()}');
      return false;
    }
  }

  //cập nhật thông tin người dùng
  Future<bool> updateUser(UserModel userData) async {
    try {
      await db.child(userData.id).update(userData.toJson());
      return true;
    } catch (e) {
      debugPrint('Lỗi khi cập nhật người dùng: ${e.toString()}');
      return false;
    }
  }
}

import 'package:facepass/features/face_verification/data/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRemoteDatasource {
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
      return null;
    }
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';

import '../../models/face_embedding_model.dart';

class FacesRemoteDataSource {
  //collection of recognized faces
  final DatabaseReference db = FirebaseDatabase.instance.ref(
    'recognized_faces',
  );

  //lấy tất cả khuôn mặt đã được nhận diện từ database
  Future<List<FaceEmbeddingModel>> fetchRecognizedFaces() async {
    try {
      final snapshot = await db.get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<Object?, Object?>;

        return data.values.map((face) {
          final faceMap = (face as Map<Object?, Object?>).map(
            (key, value) => MapEntry(key.toString(), value),
          );
          return FaceEmbeddingModel.fromJson(faceMap);
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Lỗi : $e');
      return [];
    }
  }

  //lấy khuôn mặt đã được nhận diện từ database theo userId
  Future<FaceEmbeddingModel?> fetchRecognizedFaceByUserId(String userId) async {
    try {
      final snapshot =
          await db.orderByChild('userId').equalTo(userId).limitToFirst(1).get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<Object?, Object?>;
        final faceMap = (data.values.first as Map<Object?, Object?>).map(
          (key, value) => MapEntry(key.toString(), value),
        );
        debugPrint('Khuôn mặt đã nhận diện cho userId: $userId là: $faceMap');
        return FaceEmbeddingModel.fromJson(faceMap);
      } else {
        debugPrint('Không tìm thấy khuôn mặt đã nhận diện cho userId: $userId');
        return null;
      }
    } catch (e) {
      debugPrint('Lỗi : $e');
      return null;
    }
  }

  //thêm khuôn mặt đã được nhận diện vào database
  Future<bool> addRecognizedFace(FaceEmbeddingModel face) async {
    try {
      await db.child(face.id).set(face.toJson());
      return true;
    } catch (e) {
      debugPrint('Lỗi khi thêm khuôn mặt đã nhận diện: $e');
      return false;
    }
  }
}

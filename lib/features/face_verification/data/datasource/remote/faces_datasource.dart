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
    final snapshot = await db.get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      return data.values
          .map(
            (face) => FaceEmbeddingModel.fromJson(face as Map<String, dynamic>),
          )
          .toList();
    } else {
      return [];
    }
  }

  //thêm khuôn mặt đã được nhận diện vào database
  Future<bool> addRecognizedFace(FaceEmbeddingModel face) async {
    try {
      await db.child(face.id).set(face.toJson());
      return true;
    } catch (e) {
      debugPrint('Error adding recognized face: $e');
      return false;
    }
  }
}

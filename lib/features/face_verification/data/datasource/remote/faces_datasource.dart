import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/failrue.dart';
import '../../models/face_embedding_model.dart';

class FacesRemoteDataSource {
  //collection of recognized faces
  final DatabaseReference db = FirebaseDatabase.instance.ref(
    'recognized_faces',
  );

  //lấy tất cả khuôn mặt đã được nhận diện từ database
  Future<Either<Failure, List<FaceEmbeddingModel>>>
      fetchRecognizedFaces() async {
    try {
      final snapshot = await db.get().timeout(const Duration(seconds: 3));
      if (snapshot.exists) {
        final data = snapshot.value as Map<Object?, Object?>;

        return Right(data.values.map((face) {
          final faceMap = (face as Map<Object?, Object?>).map(
            (key, value) => MapEntry(key.toString(), value),
          );
          return FaceEmbeddingModel.fromJson(faceMap);
        }).toList());
      } else {
        return const Right([]);
      }
    } on TimeoutException {
      debugPrint('Hết thời gian chờ khi lấy danh sách khuôn mặt');
      return Left(const TimeoutFailure());
    } catch (e) {
      debugPrint('Lỗi : $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  //lấy khuôn mặt đã được nhận diện từ database theo userId
  Future<Either<Failure, FaceEmbeddingModel>> fetchRecognizedFaceByUserId(
      String userId) async {
    try {
      final snapshot = await db
          .orderByChild('userId')
          .equalTo(userId)
          .limitToFirst(1)
          .get()
          .timeout(const Duration(seconds: 3));
      if (snapshot.exists) {
        final data = snapshot.value as Map<Object?, Object?>;
        final faceMap = (data.values.first as Map<Object?, Object?>).map(
          (key, value) => MapEntry(key.toString(), value),
        );
        debugPrint('Khuôn mặt đã nhận diện cho userId: $userId là: $faceMap');
        return Right(FaceEmbeddingModel.fromJson(faceMap));
      } else {
        debugPrint('Không tìm thấy khuôn mặt đã nhận diện cho userId: $userId');
        return Left(const EmptyDataFailure());
      }
    } on TimeoutException {
      debugPrint('Hết thời gian chờ khi lấy khuôn mặt');
      return Left(const TimeoutFailure());
    } catch (e) {
      debugPrint('Lỗi : $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  //thêm khuôn mặt đã được nhận diện vào database
  Future<Either<Failure, bool>> addRecognizedFace(
      FaceEmbeddingModel face) async {
    try {
      await db
          .child(face.id)
          .set(face.toJson())
          .timeout(const Duration(seconds: 3));
      return const Right(true);
    } on TimeoutException {
      debugPrint('Hết thời gian chờ khi thêm khuôn mặt');
      return Left(const TimeoutFailure());
    } catch (e) {
      debugPrint('Lỗi khi thêm khuôn mặt đã nhận diện: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}

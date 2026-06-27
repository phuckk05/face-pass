import 'dart:async';

import 'package:facepass/core/errors/failrue.dart';
import 'package:facepass/features/face_verification/data/models/attendance_model.dart';
import 'package:facepass/features/face_verification/domain/entities/attendance.dart';
import 'package:facepass/features/face_verification/domain/utils/attendance_log_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

class AttendanceDatasource {
  final DatabaseReference db = FirebaseDatabase.instance.ref(
    'attendance_records',
  );

  //thêm nhân viên đã check in or check out vào database
  Future<Either<Failure, bool>> addAttendanceRecord(
      AttendanceModel attendance) async {
    try {
      final data = attendance.toJson()
        ..['workDate'] = AttendanceLogUtils.workDate(attendance.checkedAt)
        ..['timestamp'] = attendance.checkedAt.toIso8601String()
        ..['type'] = attendance.type == AttendanceType.checkIn
            ? 'CHECK_IN'
            : 'CHECK_OUT';
      await db
          .child(attendance.id)
          .set(data)
          .timeout(const Duration(seconds: 10));
      return const Right(true);
    } on TimeoutException {
      debugPrint('Hết thời gian chờ khi thêm bản ghi chấm công');
      return Left(const TimeoutFailure());
    } catch (e) {
      debugPrint('Lỗi khi thêm bản ghi chấm công: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  //lấy tất cả nhân viên đã check in or check out từ database
  Future<Either<Failure, List<AttendanceModel>>>
      fetchAttendanceRecords() async {
    try {
      final snapshot = await db.get().timeout(const Duration(seconds: 10));
      if (snapshot.exists) {
        final data = snapshot.value as Map<Object?, Object?>;
        final List<AttendanceModel> models = [];

        for (var record in data.values) {
          try {
            final recordMap = (record as Map<Object?, Object?>).map(
              (key, value) => MapEntry(key.toString(), value),
            );
            recordMap['type'] = switch (recordMap['type']) {
              'CHECK_IN' => 'checkIn',
              'CHECK_OUT' => 'checkOut',
              final value => value,
            };
            models.add(AttendanceModel.fromJson(recordMap));
          } catch (e) {
            debugPrint('Lỗi khi parse bản ghi chấm công: $e');
          }
        }
        return Right(models);
      } else {
        return const Right([]);
      }
    } on TimeoutException {
      debugPrint('Hết thời gian chờ khi lấy bản ghi chấm công');
      return Left(const TimeoutFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // //lấy tất cả nhân viên đã check in or check out từ database theo ngày,thang,năm
  // Future<List<AttendanceModel>> fetchAttendanceRecordsByDate(
  //   DateTime date,
  // ) async {
  //   try {
  //     final snapshot = await db
  //         .orderByChild('checkedAt')
  //         .equalTo(date.toIso8601String())
  //         .get();
  //     if (snapshot.exists) {
  //       final data = snapshot.value as Map<Object?, Object?>;
  //       return data.values.map((record) {
  //         final recordMap = (record as Map<Object?, Object?>).map(
  //           (key, value) => MapEntry(key.toString(), value),
  //         );
  //         return AttendanceModel.fromJson(recordMap);
  //       }).toList();
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }
}

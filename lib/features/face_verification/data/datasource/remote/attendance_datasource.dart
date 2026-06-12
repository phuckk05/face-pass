import 'package:facepass/features/face_verification/data/models/attendance_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class AttendanceDatasource {
  final DatabaseReference db = FirebaseDatabase.instance.ref(
    'attendance_records',
  );

  //thêm nhân viên đã check in or check out vào database
  Future<bool> addAttendanceRecord(AttendanceModel attendance) async {
    try {
      await db.child(attendance.id).set(attendance.toJson());
      return true;
    } catch (e) {
      debugPrint('Lỗi khi thêm bản ghi chấm công: $e');
      return false;
    }
  }

  //lấy tất cả nhân viên đã check in or check out từ database
  Future<List<AttendanceModel>> fetchAttendanceRecords() async {
    try {
      final snapshot = await db.get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<Object?, Object?>;

        return data.values.map((record) {
          final recordMap = (record as Map<Object?, Object?>).map(
            (key, value) => MapEntry(key.toString(), value),
          );
          return AttendanceModel.fromJson(recordMap);
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
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

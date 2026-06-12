import 'package:facepass/features/face_verification/data/datasource/remote/attendance_datasource.dart';
import 'package:facepass/features/face_verification/data/models/attendance_model.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendace_repository.dart';

class AttendanceRepositoryImpl extends AttendaceRepository {
  final AttendanceDatasource remoteDataSource;
  AttendanceRepositoryImpl({required this.remoteDataSource});
  @override
  Future<bool> addAttendance(Attendance attendance) {
    final attendanceModel = AttendanceX(attendance).toModel();
    debugPrint('bản ghi: ${attendanceModel.toJson()}');
    return remoteDataSource.addAttendanceRecord(attendanceModel);
  }

  @override
  Future<List<Attendance>> getAttendances() {
    return remoteDataSource.fetchAttendanceRecords().then((attendanceModels) {
      return attendanceModels
          .map((model) => AttendanceModelX(model).toEntity())
          .toList();
    });
  }
}

import 'package:facepass/features/face_verification/data/datasource/remote/attendance_datasource.dart';
import 'package:facepass/features/face_verification/data/models/attendance_model.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failrue.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendace_repository.dart';

class AttendanceRepositoryImpl extends AttendaceRepository {
  final AttendanceDatasource remoteDataSource;
  AttendanceRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, bool>> addAttendance(Attendance attendance) async {
    final attendanceModel = AttendanceX(attendance).toModel();
    debugPrint('bản ghi: ${attendanceModel.toJson()}');
    return await remoteDataSource.addAttendanceRecord(attendanceModel);
  }

  @override
  Future<Either<Failure, List<Attendance>>> getAttendances() async {
    final result = await remoteDataSource.fetchAttendanceRecords();
    return result.map((models) =>
        models.map((model) => AttendanceModelX(model).toEntity()).toList());
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/attendance.dart';

part 'attendance_model.g.dart';
part 'attendance_model.freezed.dart';

@freezed
abstract class AttendanceModel with _$AttendanceModel {
  const factory AttendanceModel({
    required String id,
    required String userId,
    required String userName,
    required DateTime checkedAt,
    required AttendanceType type,
    required AttendanceStatus status,
    required double similarity,
    required String gpsLocation,
    required String ipAddress,
  }) = _AttendanceModel;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  // Extension để chuyển đổi giữa Model và Entity
}

extension AttendanceModelX on AttendanceModel {
  Attendance toEntity() => Attendance(
        id: id,
        userId: userId,
        userName: userName,
        checkedAt: checkedAt,
        type: type,
        status: status,
        similarity: similarity,
        gpsLocation: gpsLocation,
        ipAddress: ipAddress,
      );
}

extension AttendanceX on Attendance {
  AttendanceModel toModel() => AttendanceModel(
        id: id,
        userId: userId,
        userName: userName,
        checkedAt: checkedAt,
        type: type,
        status: status,
        similarity: similarity,
        gpsLocation: gpsLocation,
        ipAddress: ipAddress,
      );
}

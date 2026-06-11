import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/attendance.dart';

part 'attendance_model.g.dart';
part 'attendance_model.freezed.dart';

@freezed
abstract class AttendanceModel with _$AttendanceModel {
  const factory AttendanceModel({
    required String id,
    required String userId,
    required DateTime checkedAt,
    required AttendanceType type,
    required AttendanceStatus status,
    required double similarity,
  }) = _AttendanceModel;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  // Extension để chuyển đổi giữa Model và Entity
}

extension AttendanceModelX on AttendanceModel {
  Attendance toEntity() => Attendance(
    id: id,
    userId: userId,
    checkedAt: checkedAt,
    type: type,
    status: status,
    similarity: similarity,
  );
}

extension AttendanceX on Attendance {
  AttendanceModel toModel() => AttendanceModel(
    id: id,
    userId: userId,
    checkedAt: checkedAt,
    type: type,
    status: status,
    similarity: similarity,
  );
}

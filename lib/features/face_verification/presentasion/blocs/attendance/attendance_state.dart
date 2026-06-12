part of 'attendance_bloc.dart';

enum AttendanceStateStatus { initial, loading, success, error }

@freezed
abstract class AttendanceState with _$AttendanceState {
  const factory AttendanceState({
    @Default([]) List<Attendance> data,
    @Default(AttendanceStateStatus.initial) AttendanceStateStatus status,
    String? message,
  }) = _AttendanceState;
}

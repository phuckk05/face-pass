part of 'attendance_bloc.dart';

@freezed
abstract class AttendanceState with _$AttendanceState {
  const factory AttendanceState.initial({required String? message}) =
      AttendanceInitial;
  const factory AttendanceState.loading({required String message}) =
      AttendanceLoading;
  const factory AttendanceState.success({required String message}) =
      AttendanceSuccess;
  const factory AttendanceState.successHasData({
    required List<Attendance> attendances,
  }) = AttendanceSuccessHasData;
  const factory AttendanceState.failed({required String message}) =
      AttendanceFailed;
}

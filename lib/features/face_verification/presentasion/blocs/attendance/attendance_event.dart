part of 'attendance_bloc.dart';

abstract class AttendanceEvent {}

class InitAttendanceEvent extends AttendanceEvent {}

class AddAttendanceEvent extends AttendanceEvent {
  final Attendance attendance;
  AddAttendanceEvent({required this.attendance});
}

class FetchAttendancesEvent extends AttendanceEvent {
  FetchAttendancesEvent();
}

class CheckInOutEvent extends AttendanceEvent {
  final String userId;
  final String userName;
  final double similarity;
  final String? imageBase64;
  CheckInOutEvent(
      {required this.userId,
      required this.userName,
      required this.similarity,
      this.imageBase64});
}

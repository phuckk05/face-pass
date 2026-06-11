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

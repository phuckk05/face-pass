import '../entities/attendance.dart';

abstract class AttendaceRepository {
  //thêm mới một bản ghi chấm công
  Future<bool> addAttendance(Attendance attendance);
  //lấy danh sách chấm công của một user
  Future<List<Attendance>> getAttendances();
}

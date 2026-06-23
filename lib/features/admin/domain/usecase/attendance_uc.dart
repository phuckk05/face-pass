import '../entities/attendance.dart';
import '../repositories/attendace_repository.dart';

class PushAttendance {
  final AttendaceRepository repository;
  PushAttendance({required this.repository});

  //thêm mới một bản ghi chấm công
  Future<bool> addAttendance(Attendance attendance) {
    return repository.addAttendance(attendance);
  }

  //lấy tất cả bản ghi chấm công
  Future<List<Attendance>> getAttendances() {
    return repository.getAttendances();
  }
}

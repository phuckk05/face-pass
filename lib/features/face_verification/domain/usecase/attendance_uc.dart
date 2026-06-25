import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failrue.dart';
import '../entities/attendance.dart';
import '../repositories/attendace_repository.dart';

class PushAttendance {
  final AttendaceRepository repository;
  PushAttendance({required this.repository});

  //thêm mới một bản ghi chấm công
  Future<Either<Failure, bool>> addAttendance(Attendance attendance) async {
    return await repository.addAttendance(attendance);
  }

  //lấy tất cả bản ghi chấm công
  Future<Either<Failure, List<Attendance>>> getAttendances() async {
    return await repository.getAttendances();
  }
}

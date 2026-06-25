import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failrue.dart';
import '../entities/attendance.dart';

abstract class AttendaceRepository {
  //thêm mới một bản ghi chấm công
  Future<Either<Failure, bool>> addAttendance(Attendance attendance);
  //lấy danh sách chấm công của một user
  Future<Either<Failure, List<Attendance>>> getAttendances();
}

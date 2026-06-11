import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/attendance.dart';
import '../../../domain/usecase/push_attendance.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';
part 'attendance_bloc.freezed.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final PushAttendance pushAttendance;
  AttendanceBloc({required this.pushAttendance})
    : super(AttendanceState.initial(message: null)) {
    /* 1 */
    on<AddAttendanceEvent>(_addAttendance);
    /* 2 */
    on<FetchAttendancesEvent>(_getAttendances);
  }

  //thêm một bản ghi chấm công mới
  void _addAttendance(
    AddAttendanceEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceState.loading(message: 'Đang thêm bản ghi chấm công...'));
    try {
      final isSuccess = await pushAttendance.addAttendance(event.attendance);
      if (isSuccess) {
        emit(
          AttendanceState.success(message: 'Thêm bản ghi chấm công thành công'),
        );
      } else {
        emit(AttendanceState.failed(message: 'Lỗi khi thêm bản ghi chấm công'));
      }
    } catch (e) {
      emit(AttendanceState.failed(message: 'Lỗi khi thêm bản ghi chấm công'));
    }
  }

  //lấy danh sách bản ghi chấm công
  void _getAttendances(
    FetchAttendancesEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceState.loading(message: 'Đang tải danh sách chấm công...'));
    try {
      final attendances = await pushAttendance.getAttendances();
      emit(AttendanceState.successHasData(attendances: attendances));
    } catch (e) {
      emit(AttendanceState.failed(message: 'Lỗi khi tải danh sách chấm công'));
    }
  }
}

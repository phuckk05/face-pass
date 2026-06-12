import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/attendance.dart';
import '../../../domain/usecase/attendance_uc.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';
part 'attendance_bloc.freezed.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final PushAttendance pushAttendance;
  AttendanceBloc({required this.pushAttendance})
    : super(AttendanceState(status: AttendanceStateStatus.initial, data: [])) {
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
    emit(state.copyWith(status: AttendanceStateStatus.loading));
    try {
      final isSuccess = await pushAttendance.addAttendance(event.attendance);
      if (isSuccess) {
        emit(
          state.copyWith(
            status: AttendanceStateStatus.success,
            data: [...state.data, event.attendance],
            message: 'Chấm công thành công',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AttendanceStateStatus.error,
            message: 'Chấm công thất bại',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AttendanceStateStatus.error,
          message: 'Đã xảy ra lỗi',
        ),
      );
    }
  }

  //lấy danh sách bản ghi chấm công
  void _getAttendances(
    FetchAttendancesEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(status: AttendanceStateStatus.loading, data: []));
    try {
      final attendances = await pushAttendance.getAttendances();
      emit(
        state.copyWith(
          status: AttendanceStateStatus.success,
          data: attendances,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AttendanceStateStatus.error,
          message: 'Đã xảy ra lỗi',
          data: [],
        ),
      );
    }
  }
}

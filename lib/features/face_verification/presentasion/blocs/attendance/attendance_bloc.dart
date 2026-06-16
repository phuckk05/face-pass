import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/attendance.dart';
import '../../../domain/usecase/attendance_uc.dart';
import '../../../../../core/utils/permission_utils.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';
part 'attendance_bloc.freezed.dart';

/* BLoC quản lý trạng thái của quá trình Chấm Công (Check-in / Check-out) */
class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final PushAttendance pushAttendance;
  AttendanceBloc({required this.pushAttendance})
      : super(
            AttendanceState(status: AttendanceStateStatus.initial, data: [])) {
    /* 1 */
    on<AddAttendanceEvent>(_addAttendance);
    /* 2 */
    on<FetchAttendancesEvent>(_getAttendances);
    /* 3 */
    on<CheckInOutEvent>(_checkInOutEvent);
  }

  /* 
   * Xử lý sự kiện thêm bản ghi chấm công lên server (Firebase)
   * Thay đổi trạng thái sang loading, gọi usecase và emit trạng thái mới (thành công hoặc lỗi)
   */
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

  /* 
   * Lấy toàn bộ danh sách điểm danh từ server
   * Sử dụng khi mới khởi tạo ứng dụng hoặc refresh lại lịch sử
   */
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

  /* 
   * Logic kiểm tra và quyết định việc Check-in hay Check-out 
   * - Tìm kiếm lịch sử điểm danh của user trong ngày hôm nay.
   * - Nếu chưa có bản ghi nào: Đánh dấu là Check-in.
   * - Nếu đã có Check-in nhưng chưa Check-out: Đánh dấu là Check-out.
   * - Lấy kèm toạ độ GPS và IP từ thiết bị.
   */
  void _checkInOutEvent(
    CheckInOutEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    final attendances = state.data;
    final now = DateTime.now();

    final userRecords = attendances.where((record) {
      return record.userId == event.userId &&
          record.checkedAt.year == now.year &&
          record.checkedAt.month == now.month &&
          record.checkedAt.day == now.day;
    }).toList();

    final workStartTime = DateTime(now.year, now.month, now.day, 8);
    final workEndTime = DateTime(now.year, now.month, now.day, 17);

    final hasCheckedOut =
        userRecords.any((e) => e.type == AttendanceType.checkOut);

    if (hasCheckedOut) {
      emit(state.copyWith(
          status: AttendanceStateStatus.error,
          message: 'Bạn đã check out hôm nay rồi'));
      return;
    }

    final gpsLocation = await PermissionUtils.getGPSLocation();
    final ipAddress = await PermissionUtils.getIpAddress();

    final hasCheckedIn =
        userRecords.any((e) => e.type == AttendanceType.checkIn);

    if (hasCheckedIn) {
      final attendance = Attendance(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          userId: event.userId,
          checkedAt: now,
          type: AttendanceType.checkOut,
          status: now.isBefore(workEndTime)
              ? AttendanceStatus.early
              : AttendanceStatus.onTime,
          similarity: event.similarity,
          gpsLocation: '${gpsLocation.latitude},${gpsLocation.longitude}',
          ipAddress: ipAddress);

      add(AddAttendanceEvent(attendance: attendance));
      emit(state.copyWith(
          status: AttendanceStateStatus.success,
          message: 'Check out thành công'));
      return;
    }

    final attendance = Attendance(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: event.userId,
        checkedAt: now,
        type: AttendanceType.checkIn,
        status: now.isAfter(workStartTime)
            ? AttendanceStatus.late
            : AttendanceStatus.onTime,
        similarity: event.similarity,
        gpsLocation: '${gpsLocation.latitude},${gpsLocation.longitude}',
        ipAddress: ipAddress);

    add(AddAttendanceEvent(attendance: attendance));
    emit(state.copyWith(
        status: AttendanceStateStatus.success, message: 'Check in thành công'));
  }
}

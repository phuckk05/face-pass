import 'dart:async';

import 'package:facepass/core/services/google_sheet_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/utils/permission_utils.dart';
import '../../../domain/entities/attendance.dart';
import '../../../domain/usecase/attendance_uc.dart';
import '../../../domain/utils/attendance_log_utils.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';
part 'attendance_bloc.freezed.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final PushAttendance pushAttendance;
  final GoogleSheetService googleSheetService;

  AttendanceBloc({
    required this.pushAttendance,
    GoogleSheetService? googleSheetService,
  })  : googleSheetService = googleSheetService ?? GoogleSheetService(),
        super(
          const AttendanceState(
            status: AttendanceStateStatus.initial,
            data: [],
          ),
        ) {
    on<AddAttendanceEvent>(_addAttendance);
    on<FetchAttendancesEvent>(_getAttendances);
    on<CheckInOutEvent>(_checkInOutEvent);
  }

  void _addAttendance(
    AddAttendanceEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(status: AttendanceStateStatus.loading));
    final result = await pushAttendance.addAttendance(event.attendance);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AttendanceStateStatus.error,
          message: failure.message,
        ),
      ),
      (isSuccess) {
        if (isSuccess) {
          unawaited(googleSheetService.pushAttendance(event.attendance));
          final nextData = [...state.data, event.attendance]
            ..sort((a, b) => a.checkedAt.compareTo(b.checkedAt));
          emit(
            state.copyWith(
              status: AttendanceStateStatus.success,
              data: nextData,
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
      },
    );
  }

  void _getAttendances(
    FetchAttendancesEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(status: AttendanceStateStatus.loading, data: []));
    final result = await pushAttendance.getAttendances();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AttendanceStateStatus.error,
          message: failure.message,
          data: [],
        ),
      ),
      (attendances) {
        final sorted = [...attendances]
          ..sort((a, b) => a.checkedAt.compareTo(b.checkedAt));
        emit(
          state.copyWith(
            status: AttendanceStateStatus.success,
            data: sorted,
          ),
        );
      },
    );
  }

  void _checkInOutEvent(
    CheckInOutEvent event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(status: AttendanceStateStatus.loading));

    final now = DateTime.now();

    // Lấy log hôm nay của user
    final todayLogs = AttendanceLogUtils.logsForDate(
      logs: state.data,
      userId: event.userId,
      date: now,
    );

    // Xác định lần chấm tiếp theo là CheckIn hay CheckOut
    final nextType = AttendanceLogUtils.nextType(todayLogs);

    // Mốc phân chia ca
    final shiftSplitTime = DateTime(
      now.year,
      now.month,
      now.day,
      13,
      30,
    );

// Ca 1
    final shift1Start = DateTime(
      now.year,
      now.month,
      now.day,
      9,
      0,
    );

    final shift1Late = DateTime(
      now.year,
      now.month,
      now.day,
      9,
      15,
    );

    final shift1End = DateTime(
      now.year,
      now.month,
      now.day,
      13,
      0,
    );

    // Ca 2
    final shift2Start = DateTime(
      now.year,
      now.month,
      now.day,
      14,
      0,
    );

    final shift2Late = DateTime(
      now.year,
      now.month,
      now.day,
      14,
      15,
    );

    final shift2End = DateTime(
      now.year,
      now.month,
      now.day,
      18,
      0,
    );

    //xác định ca làm
    final isShift1 = now.isBefore(shiftSplitTime);

    AttendanceStatus attendanceStatus;

    if (isShift1) {
      //ca 1

      if (nextType == AttendanceType.checkIn) {
        attendanceStatus = now.isAfter(shift1Late)
            ? AttendanceStatus.late
            : AttendanceStatus.onTime;
      } else {
        attendanceStatus = now.isBefore(shift1End)
            ? AttendanceStatus.early
            : AttendanceStatus.onTime;
      }
    } else {
      //ca 2
      if (nextType == AttendanceType.checkIn) {
        attendanceStatus = now.isAfter(shift2Late)
            ? AttendanceStatus.late
            : AttendanceStatus.onTime;
      } else {
        attendanceStatus = now.isBefore(shift2End)
            ? AttendanceStatus.early
            : AttendanceStatus.onTime;
      }
    }

    try {
      final gpsLocation = await PermissionUtils.getGPSLocation();
      final ipAddress = await PermissionUtils.getIpAddress();
      final attendance = Attendance(
        id: now.microsecondsSinceEpoch.toString(),
        userId: event.userId,
        userName: event.userName,
        checkedAt: now,
        type: nextType,
        status: attendanceStatus,
        similarity: event.similarity,
        imageBase64: event.imageBase64,
        gpsLocation: '${gpsLocation.latitude},${gpsLocation.longitude}',
        ipAddress: ipAddress,
      );

      final result = await pushAttendance.addAttendance(attendance);
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: AttendanceStateStatus.error,
            message: failure.message,
          ),
        ),
        (isSuccess) {
          if (!isSuccess) {
            emit(
              state.copyWith(
                status: AttendanceStateStatus.error,
                message: 'Chấm công thất bại',
              ),
            );
            return;
          }

          final nextData = [...state.data, attendance]
            ..sort((a, b) => a.checkedAt.compareTo(b.checkedAt));
          unawaited(googleSheetService.pushAttendance(attendance));
          final actionText =
              nextType == AttendanceType.checkIn ? 'vào ca' : 'ra ca';
          emit(
            state.copyWith(
              status: AttendanceStateStatus.success,
              data: nextData,
              message: 'Chấm công $actionText thành công',
            ),
          );
        },
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AttendanceStateStatus.error,
          message: 'Không thể lấy vị trí hoặc lưu chấm công',
        ),
      );
    }
  }
}

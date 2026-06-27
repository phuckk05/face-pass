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
    final todayLogs = AttendanceLogUtils.logsForDate(
      logs: state.data,
      userId: event.userId,
      date: now,
    );
    final nextType = AttendanceLogUtils.nextType(todayLogs);
    final workStartTime = DateTime(now.year, now.month, now.day, 8);
    final workEndTime = DateTime(now.year, now.month, now.day, 17);

    try {
      final gpsLocation = await PermissionUtils.getGPSLocation();
      final ipAddress = await PermissionUtils.getIpAddress();
      final attendance = Attendance(
        id: now.microsecondsSinceEpoch.toString(),
        userId: event.userId,
        userName: event.userName,
        checkedAt: now,
        type: nextType,
        status: nextType == AttendanceType.checkIn
            ? (now.isAfter(workStartTime)
                ? AttendanceStatus.late
                : AttendanceStatus.onTime)
            : (now.isBefore(workEndTime)
                ? AttendanceStatus.early
                : AttendanceStatus.onTime),
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

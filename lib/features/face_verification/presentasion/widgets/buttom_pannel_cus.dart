import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/attendance.dart';
import '../../domain/utils/attendance_log_utils.dart';
import '../blocs/attendance/attendance_bloc.dart';
import '../blocs/recognizing_face/recognizing_face_bloc.dart';

class ButtomPannelCus extends StatelessWidget {
  final int index;
  final Widget recognizingBloc;
  final VoidCallback onScan;
  final VoidCallback onCheck;
  final String? userId;

  const ButtomPannelCus({
    super.key,
    required this.index,
    required this.recognizingBloc,
    required this.onScan,
    required this.onCheck,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: recognizingBloc,
          ),
          const SizedBox(height: 10),
          if (index != 1 && userId != null) ...[
            _AttendanceTodaySummary(userId: userId!),
            const SizedBox(height: 10),
          ],
          Row(
            children: [
              Expanded(
                child: BlocBuilder<RecognizingFaceBloc, RecognizingFaceState>(
                  builder: (context, state) {
                    final isProcessing = state.maybeWhen(
                      processingUpdate: (embedding, message) => false,
                      initial: (messge) => true,
                      similaritySuccess: (embedding, messge) => true,
                      processingErrol: (message) => true,
                      processing: (messge) => false,
                      success: (embedding, message) => true,
                      failed: (message) => true,
                      orElse: () => true,
                    );
                    final isCheckSuccess = state.maybeWhen(
                      initial: (messge) => true,
                      similaritySuccess: (embedding, messge) => true,
                      processing: (messge) => false,
                      processingErrol: (message) => true,
                      failed: (message) => true,
                      orElse: () => false,
                    );

                    return FilledButton(
                      onPressed: index == 1
                          ? (isProcessing ? onScan : null)
                          : (isCheckSuccess ? onCheck : null),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF2d6a4f),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        index == 1 ? 'Đăng ký khuôn mặt' : 'Chấm công',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AttendanceTodaySummary extends StatelessWidget {
  final String userId;

  const _AttendanceTodaySummary({required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final todayLogs = AttendanceLogUtils.logsForToday(
          logs: state.data,
          userId: userId,
        );
        final nextType = AttendanceLogUtils.nextType(todayLogs);
        final completedShifts =
            AttendanceLogUtils.completedShiftCount(todayLogs);
        final statusText = nextType == AttendanceType.checkIn
            ? (todayLogs.isEmpty ? 'Chưa vào ca' : 'Đã ra ca')
            : 'Đang trong ca';

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            border: Border.all(color: Colors.white.withOpacity(0.10)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      statusText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    '$completedShifts ca hoàn thành',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (todayLogs.isEmpty)
                const Text(
                  'Hôm nay chưa có lịch sử chấm công',
                  style: TextStyle(color: Colors.white70),
                )
              else
                ...todayLogs.map((log) => _AttendanceLogLine(log: log)),
              if (AttendanceLogUtils.hasOpenShift(todayLogs)) ...[
                const SizedBox(height: 4),
                const Text(
                  'Ca gần nhất: Chưa chấm ra',
                  style: TextStyle(color: Colors.amberAccent),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _AttendanceLogLine extends StatelessWidget {
  final Attendance log;

  const _AttendanceLogLine({required this.log});

  @override
  Widget build(BuildContext context) {
    final time =
        '${log.checkedAt.hour.toString().padLeft(2, '0')}:${log.checkedAt.minute.toString().padLeft(2, '0')}';
    final label = log.type == AttendanceType.checkIn ? 'Vào' : 'Ra';

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        '$time - $label',
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}

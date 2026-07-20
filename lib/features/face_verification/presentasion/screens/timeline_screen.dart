import 'package:facepass/core/constants/app_colors.dart';
import 'package:facepass/core/utils/scaffold_messenger_utils.dart';
import 'package:facepass/features/face_verification/presentasion/blocs/attendance/attendance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';

import '../../../../core/utils/camera_utils.dart';
import '../../../../core/utils/excel_services.dart';
import '../../domain/entities/attendance.dart';
import '../widgets/late_attendance_chart.dart';
import '../widgets/timeline_cus.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          automaticallyImplyActions: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Đi trễ', style: TextStyle(color: Colors.white)),
          backgroundColor: AppColors.primary,
          elevation: 0,
          actions: [
            BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.file_download, color: Colors.white),
                  onPressed: state.data.isEmpty
                      ? null
                      : () async {
                          final path =
                              await ExcelServices().createExcelAttendanceFile(
                            data: state.data,
                            fileName: 'facepass_attendance',
                          );

                          if (!context.mounted) return;

                          if (path == null) {
                            ScaffoldMessengerUtils.error(
                                context, 'Không thể xuất file Excel');
                            return;
                          }

                          await OpenFile.open(path);
                        },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            if (state.data.isEmpty) {
              return const Center(
                child: Text('Không có dữ liệu điểm danh'),
              );
            }
            final attendanceCheckIn = state.data
                .where((a) =>
                    a.type == AttendanceType.checkIn &&
                    a.status == AttendanceStatus.late)
                .toList();

            attendanceCheckIn
                .sort((a, b) => b.checkedAt.compareTo(a.checkedAt));

            final groupedAttendances = <String, List<Attendance>>{};
            for (var a in attendanceCheckIn) {
              final now = DateTime.now();
              final today = DateTime(now.year, now.month, now.day);
              final yesterday = today.subtract(const Duration(days: 1));
              final aDate = DateTime(
                  a.checkedAt.year, a.checkedAt.month, a.checkedAt.day);

              String dateStr = '';
              if (aDate == today) {
                dateStr =
                    'Hôm nay, ${a.checkedAt.day.toString().padLeft(2, '0')}/${a.checkedAt.month.toString().padLeft(2, '0')}';
              } else if (aDate == yesterday) {
                dateStr =
                    'Hôm qua, ${a.checkedAt.day.toString().padLeft(2, '0')}/${a.checkedAt.month.toString().padLeft(2, '0')}';
              } else {
                dateStr =
                    '${a.checkedAt.day.toString().padLeft(2, '0')}/${a.checkedAt.month.toString().padLeft(2, '0')}/${a.checkedAt.year}';
              }

              if (!groupedAttendances.containsKey(dateStr)) {
                groupedAttendances[dateStr] = [];
              }
              groupedAttendances[dateStr]!.add(a);
            }

            final slivers = <Widget>[
              if (attendanceCheckIn.isNotEmpty)
                SliverToBoxAdapter(
                  child: LateAttendanceChart(attendances: attendanceCheckIn),
                ),
            ];

            groupedAttendances.forEach((dateStr, list) {
              slivers.add(
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 8, bottom: 8),
                    child: Text(
                      dateStr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              );

              slivers.add(
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final attendance = list[index];
                      final lateTime = CameraUtils.calculateLateTime(
                          attendance.checkedAt.toString());
                      return TimelineCus(
                        attendance: attendance,
                        lateTime: lateTime,
                        name: attendance.userName,
                      );
                    },
                    childCount: list.length,
                  ),
                ),
              );
            });

            slivers
                .add(const SliverPadding(padding: EdgeInsets.only(bottom: 24)));

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: slivers,
            );
          },
        ));
  }

}

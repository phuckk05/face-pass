import 'package:facepass/features/face_verification/presentasion/blocs/attendance/attendance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/camera_utils.dart';
import '../../domain/entities/attendance.dart';
import '../widgets/timeline_cus.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyActions: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Đi trễ', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF2d6a4f),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                if (state.data.isEmpty) {
                  return const Center(
                    child: Text('Không có dữ liệu điểm danh'),
                  );
                }
                final attendanceCheckIn = state.data.where((a) =>
                    a.type == AttendanceType.checkIn &&
                    a.status == AttendanceStatus.late);
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: attendanceCheckIn.length,
                  itemBuilder: (context, index) {
                    final lateTime = CameraUtils.calculateLateTime(
                        attendanceCheckIn
                            .elementAt(index)
                            .checkedAt
                            .toString());
                    return TimelineCus(
                      attendance: attendanceCheckIn.elementAt(index),
                      lateTime: lateTime,
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}

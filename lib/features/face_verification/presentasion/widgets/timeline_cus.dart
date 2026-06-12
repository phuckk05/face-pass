import 'package:facepass/core/utils/camera_utils.dart';
import 'package:facepass/features/face_verification/domain/entities/attendance.dart';
import 'package:flutter/material.dart';

class TimelineCus extends StatelessWidget {
  final Attendance attendance;
  final String lateTime;
  const TimelineCus({
    super.key,
    required this.attendance,
    this.lateTime = '15 phút',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2d6a4f),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        width: 2,
                        height: 60,
                        color: const Color(0xFF2d6a4f),
                      ),
                    ],
                  ),
                ],
              )),
          Expanded(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF2d6a4f), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        attendance.userId,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        CameraUtils.formatTime(attendance.checkedAt.toString()),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                  Text(
                    'Đi trễ $lateTime',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

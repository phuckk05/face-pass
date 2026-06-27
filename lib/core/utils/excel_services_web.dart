import 'package:facepass/features/face_verification/domain/entities/attendance.dart';
import 'package:flutter/rendering.dart';

class ExcelServices {
  Future<String?> createExcelAttendanceFile({
    required List<Attendance> data,
    String? fileName,
  }) async {
    debugPrint('Excel export is not supported on web yet.');
    return null;
  }
}

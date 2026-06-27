import 'dart:convert';

import 'package:facepass/features/face_verification/domain/entities/attendance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GoogleSheetService {
  String get _scriptUrl => dotenv.env['GOOGLE_SHEET_SCRIPT_URL'] ?? '';
  String get _secret => dotenv.env['GOOGLE_SHEET_SECRET'] ?? '';

  bool get isConfigured =>
      _scriptUrl.trim().isNotEmpty && _secret.trim().isNotEmpty;

  Future<bool> pushAttendance(Attendance attendance) async {
    if (!isConfigured) {
      debugPrint('Google Sheet sync skipped: Apps Script URL is empty.');
      return false;
    }

    try {
      final request = http.Request('POST', Uri.parse(_scriptUrl));

      request.headers.addAll({
        'Content-Type': 'application/json',
      });

      request.body = jsonEncode({
        'secret': _secret,
        'id': attendance.id,
        'userId': attendance.userId,
        'userName': attendance.userName,
        'checkedAt': attendance.checkedAt.toIso8601String(),
        'type': attendance.type == AttendanceType.checkIn
            ? 'CHECK_IN'
            : 'CHECK_OUT',
        'status': _statusText(attendance.status),
        'similarity': attendance.similarity,
        'gpsLocation': attendance.gpsLocation,
        'ipAddress': attendance.ipAddress,
      });

      final streamedResponse = await request.send().timeout(
            const Duration(seconds: 10),
          );

      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('Google Sheet status: ${response.statusCode}');
      debugPrint('Google Sheet body: ${response.body}');

      if (response.statusCode != 200) {
        return false;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['success'] == true;
    } catch (e) {
      debugPrint('Google Sheet sync error: $e');
      return false;
    }
  }

  String _statusText(AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.onTime => 'Đúng giờ',
      AttendanceStatus.late => 'Trễ',
      AttendanceStatus.absent => 'Vắng',
      AttendanceStatus.early => 'Sớm',
    };
  }
}

import '../entities/attendance.dart';

class AttendanceLogUtils {
  static List<Attendance> logsForDate({
    required List<Attendance> logs,
    required String userId,
    required DateTime date,
  }) {
    final dayLogs = logs.where((log) {
      return log.userId == userId &&
          log.checkedAt.year == date.year &&
          log.checkedAt.month == date.month &&
          log.checkedAt.day == date.day;
    }).toList()
      ..sort((a, b) => a.checkedAt.compareTo(b.checkedAt));

    return dayLogs;
  }

  static List<Attendance> logsForToday({
    required List<Attendance> logs,
    required String userId,
  }) {
    return logsForDate(logs: logs, userId: userId, date: DateTime.now());
  }

  static AttendanceType nextType(List<Attendance> todayLogs) {
    return todayLogs.length.isEven
        ? AttendanceType.checkIn
        : AttendanceType.checkOut;
  }

  static int completedShiftCount(List<Attendance> todayLogs) {
    return todayLogs.length ~/ 2;
  }

  static bool hasOpenShift(List<Attendance> todayLogs) {
    return todayLogs.length.isOdd;
  }

  static String workDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}

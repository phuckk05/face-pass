class Attendance {
  final String id;
  final String userId;
  final DateTime checkedAt;
  final AttendanceType type;
  final AttendanceStatus status;
  final double similarity;

  const Attendance({
    required this.id,
    required this.userId,
    required this.checkedAt,
    required this.type,
    required this.status,
    required this.similarity,
  });
}

enum AttendanceType { checkIn, checkOut }

enum AttendanceStatus { onTime, late, absent }

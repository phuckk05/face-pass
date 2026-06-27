class Attendance {
  final String id;
  final String userId;
  final String userName;
  final DateTime checkedAt;
  final AttendanceType type;
  final AttendanceStatus status;
  final double similarity;
  final String? imageBase64;

  //thêm gps
  final String gpsLocation;
  //thêm ip address
  final String ipAddress;

  const Attendance({
    required this.id,
    required this.userId,
    required this.userName,
    required this.checkedAt,
    required this.type,
    required this.status,
    required this.similarity,
    this.imageBase64,
    required this.gpsLocation,
    required this.ipAddress,
  });
}

enum AttendanceType { checkIn, checkOut }

enum AttendanceStatus { onTime, late, absent, early }

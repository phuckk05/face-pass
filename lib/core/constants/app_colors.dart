import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  // Brand / Primary (logo, nút Đăng xuất, item sidebar đang chọn)
  static const Color primary = Color(0xFF3B82F6); // blue-500
  static const Color primaryDark = Color(0xFF2563EB); // blue-600
  static const Color primaryLight =
      Color(0xFFEFF6FF); // blue-50 (nền item active)
  static const Color primarySoft =
      Color(0xFFDBEAFE); // blue-100 (nền icon tròn)

  // Success / green (badge "Đã vào làm", "Đúng giờ", "EMPLOYEE")
  static const Color success = Color(0xFF16A34A); // green-600
  static const Color successBg = Color(0xFFDCFCE7); // green-100
  static const Color successSoft =
      Color(0xFFECFDF5); // nền icon "Xin nghỉ phép"

  // Danger / cảnh báo (chữ "TTS" trong banner thông báo)
  static const Color danger = Color(0xFFDC2626); // red-600

  // Banner thông báo (nền xanh lavender nhạt phía trên dashboard)
  static const Color noticeBg = Color(0xFFE0E7FF); // indigo-100

  // Nền tổng thể trang
  static const Color background = Color(0xFFF3F4F6); // gray-100
  static const Color surface = Color(0xFFFFFFFF); // card / sidebar / header
  static const Color surfaceMuted = Color(0xFFF9FAFB); // nền header bảng

  // Border / divider
  static const Color border = Color(0xFFE5E7EB); // gray-200
  static const Color divider = Color(0xFFF0F1F3);

  // Text
  static const Color textPrimary = Color(0xFF111827); // gray-900 (tiêu đề)
  static const Color textSecondary = Color(0xFF4B5563); // gray-600 (mô tả)
  static const Color textMuted =
      Color(0xFF9CA3AF); // gray-400 (placeholder, "Chưa")
  static const Color textOnPrimary = Color(0xFFFFFFFF);
}

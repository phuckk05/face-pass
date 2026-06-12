import 'dart:io';

import 'package:excel/excel.dart';
import 'package:facepass/features/face_verification/domain/entities/attendance.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ExcelServices {
  /* Định nghĩa các phương thức phục vụ cho việc xử lý file Excel */

  Future<String?> createExcelAttendanceFile(
      {required List<Attendance> data, String? fileName}) async {
    try {
      if (data.isEmpty) return null;
      final sortedData = [...data]
        ..sort((a, b) => a.checkedAt.compareTo(b.checkedAt));

      final records = sortedData
          .map((a) => {
                'Mã NV': a.userId,
                'Ngày':
                    '${a.checkedAt.day}/${a.checkedAt.month}/${a.checkedAt.year}',
                'Thời gian': a.checkedAt.hour.toString().padLeft(2, '0') +
                    ':' +
                    a.checkedAt.minute.toString().padLeft(2, '0'),
                ' Loại':
                    a.type == AttendanceType.checkIn ? 'Check-in' : 'Check-out',
                'Trạng thái': a.status == AttendanceStatus.onTime
                    ? 'Đúng giờ'
                    : a.status == AttendanceStatus.late
                        ? 'Trễ'
                        : a.status == AttendanceStatus.absent
                            ? 'Vắng mặt'
                            : 'Sớm',
              })
          .toList();

      //khởi tạo excel
      final excel = Excel.createExcel();
      //tạo sheet
      final sheet = excel['Danh sách điểm danh'];
      excel.setDefaultSheet('Danh sách điểm danh');

      //lấy header
      final firstItem = records.first as Map<String, dynamic>;
      final header = firstItem.keys.toList();

      //tạo các hàng header
      for (var i = 0; i < header.length; i++) {
        final cell =
            sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
        cell.value = TextCellValue(header[i]);
        cell.cellStyle = CellStyle(
          bold: true,
          fontSize: 12,
          horizontalAlign: HorizontalAlign.Center,
          verticalAlign: VerticalAlign.Center,
        );
      }

      //đổ data vào excel
      for (var i = 0; i < records.length; i++) {
        final item = records[i] as Map<String, dynamic>;

        for (var j = 0; j < header.length; j++) {
          final value = item[header[j]];
          final cell = sheet.cell(
              CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 1));

          if (value is num) {
            cell.value = DoubleCellValue(value.toDouble());
          } else if (value is DateTime) {
            cell.value = TextCellValue(
              '${value.day}/${value.month}/${value.year} ${value.hour}:${value.minute}',
            );
          } else {
            cell.value = TextCellValue(value.toString());
          }
        }
      }

      //định dạng cột
      for (int col = 0; col < header.length; col++) {
        sheet.setColumnWidth(col, 18);
      }
      //lưu file
      final fileBytes = excel.save();
      if (fileBytes == null) return null;

      final path = await _getSavePath(fileName!);
      final file = File(path);
      await file.writeAsBytes(fileBytes);

      return path;
    } catch (e) {
      debugPrint('Lỗi xuất Excel: $e');
      return null;
    }
  }

  //lấy đường dẫn lưu file
  static Future<String> _getSavePath(String fileName) async {
    final timestamp = DateTime.now();
    final name =
        '${fileName}_${timestamp.day}_${timestamp.month}_${timestamp.year}.xlsx';

    if (Platform.isAndroid) {
      // Xin quyền
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }

      // Lưu vào Download
      final dir = Directory('/storage/emulated/0/Download');
      if (await dir.exists()) {
        return '${dir.path}/$name';
      }
    }

    //Lưu vào doc của thiết bị
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$name';
  }
}

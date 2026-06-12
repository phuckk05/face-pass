import 'package:facepass/features/face_verification/presentasion/blocs/attendance/attendance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/router_app.dart';
import '../../../../core/utils/excel_services.dart';
import '../blocs/recognized_faces/recognized_faces_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(
      context.read<RecognizedFacesBloc>().state.maybeWhen(
            hasData: (recognizedFaces) =>
                'Has data: ${recognizedFaces.length} faces',
            orElse: () => 'No data available',
          ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Các chức năng', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2d6a4f),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFF2d6a4f),
                ),
                onPressed: () {
                  context.pushNamed(
                    cameraRouteName,
                    pathParameters: {'index': '1'},
                  );
                },
                child: const Text(
                  'Đăng ký khuôn mặt',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFF2d6a4f),
                ),
                onPressed: () {
                  context.pushNamed(
                    cameraRouteName,
                    pathParameters: {'index': '2'},
                  );
                },
                child: const Text(
                  'Nhận diện khuôn mặt',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFF2d6a4f),
                ),
                onPressed: () async {
                  //lấy data điểm danh
                  final data = context.read<AttendanceBloc>().state.data;
                  //xuất file excel
                  final createExcel = await ExcelServices()
                      .createExcelAttendanceFile(
                          data: data, fileName: 'Lịch sử điểm danh');
                  if (createExcel != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('File đã được lưu tại: $createExcel'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Lỗi khi tạo file Excel'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Tải file excel',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFF2d6a4f),
                ),
                onPressed: () {},
                child: const Text(
                  'Timeline đi trễ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

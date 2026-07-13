import 'package:facepass/core/utils/permission_utils.dart';
import 'package:facepass/core/widgets/button_cus.dart';
import 'package:facepass/features/face_verification/presentasion/blocs/attendance/attendance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/router_app.dart';
import '../../../../core/utils/excel_services.dart';
import '../../../auth/presentation/blocs/auth/auth_bloc.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  void permissionDenied(BuildContext context) {
    PermissionUtils.requestLocationPermissions().then((granted) {
      if (!granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng cấp quyền vị trí để sử dụng ứng dụng'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    permissionDenied(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 56,
            floating: true,
            snap: true,
            // pinned: false,
            // elevation: AppValues.cardElevation,
            backgroundColor: AppColors.primary,
            title: Text(
              'Admin',
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              //logout button
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  //xóa data auth
                  context.read<AuthBloc>().add(AuthReset());
                  context.goNamed(loginRouteName);
                },
              ),
            ],
          ),
          //body
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ButtonCus(
                      isLoading: false,
                      text: 'Quản lý tài khoản',
                      width: double.infinity,
                      textColor: AppColors.primaryLight,
                      height: 50,
                      onPressed: () async {
                        context.pushNamed(manageAccountRouteName);
                      },
                      textStyle: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  ButtonCus(
                      isLoading: false,
                      text: 'Cấp tài khoản',
                      width: double.infinity,
                      height: 50,
                      textColor: AppColors.primaryLight,
                      onPressed: () {
                        context.pushNamed(grantAccountRouteName);
                      },
                      textStyle: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  ButtonCus(
                      isLoading: false,
                      text: 'Tải file excel',
                      width: double.infinity,
                      height: 50,
                      textColor: AppColors.primaryLight,
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
                              content:
                                  Text('File đã được lưu tại: $createExcel'),
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
                      textStyle: const TextStyle(fontSize: 16)),
                  // const SizedBox(height: 20),

                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 24,
                  //         vertical: 12,
                  //       ),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       backgroundColor: const Color(0xFF2d6a4f),
                  //     ),
                  //     onPressed: () {
                  //       context.pushNamed(
                  //         cameraRouteName,
                  //         pathParameters: {'index': '1'},
                  //       );
                  //     },
                  //     child: const Text(
                  //       'Đăng ký khuôn mặt',
                  //       style: TextStyle(fontSize: 16, color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  ButtonCus(
                      isLoading: false,
                      text: 'Chấm công',
                      width: double.infinity,
                      height: 50,
                      textColor: AppColors.primaryLight,
                      onPressed: () {
                        context.pushNamed(
                          cameraRouteName,
                          extra: {
                            'index': 2,
                            'user': context.read<AuthBloc>().state.user
                          },
                        );
                      },
                      textStyle: const TextStyle(fontSize: 16)),

                  // const SizedBox(height: 20),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 24,
                  //         vertical: 12,
                  //       ),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       backgroundColor: const Color(0xFF2d6a4f),
                  //     ),
                  //     onPressed: () async {
                  //       //lấy data điểm danh
                  //       final data = context.read<AttendanceBloc>().state.data;
                  //       //xuất file excel
                  //       final createExcel = await ExcelServices()
                  //           .createExcelAttendanceFile(
                  //               data: data, fileName: 'Lịch sử điểm danh');
                  //       if (createExcel != null) {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(
                  //             content: Text('File đã được lưu tại: $createExcel'),
                  //           ),
                  //         );
                  //       } else {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           const SnackBar(
                  //             content: Text('Lỗi khi tạo file Excel'),
                  //           ),
                  //         );
                  //       }
                  //     },
                  //     child: const Text(
                  //       'Tải file excel',
                  //       style: TextStyle(fontSize: 16, color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  ButtonCus(
                    isLoading: false,
                    textColor: AppColors.primaryLight,
                    text: 'Time line đi trễ',
                    width: double.infinity,
                    height: 50,
                    textStyle: const TextStyle(fontSize: 16),
                    onPressed: () {
                      context.pushNamed(timelineRouteName);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

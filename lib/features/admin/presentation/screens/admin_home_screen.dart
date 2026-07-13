import 'package:facepass/core/utils/permission_utils.dart';
import 'package:facepass/core/utils/scaffold_messenger_utils.dart';
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
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
              title: const Text(
                'Bảng Điều Khiển',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 0.5,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      top: -50,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.logout_rounded, color: Colors.white),
                  tooltip: 'Đăng xuất',
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthReset());
                    context.goNamed(loginRouteName);
                  },
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildListDelegate([
                _buildDashboardCard(
                  context: context,
                  title: 'Quản lý\ntài khoản',
                  icon: Icons.manage_accounts_rounded,
                  color: const Color(0xFF4361EE),
                  onTap: () => context.pushNamed(manageAccountRouteName),
                ),
                _buildDashboardCard(
                  context: context,
                  title: 'Cấp\ntài khoản',
                  icon: Icons.person_add_alt_1_rounded,
                  color: const Color(0xFF2ECC71),
                  onTap: () => context.pushNamed(grantAccountRouteName),
                ),
                _buildDashboardCard(
                  context: context,
                  title: 'Chấm công\n',
                  icon: Icons.fact_check_rounded,
                  color: const Color(0xFFF39C12),
                  onTap: () => context.pushNamed(
                    cameraRouteName,
                    extra: {
                      'index': 2,
                      'user': context.read<AuthBloc>().state.user
                    },
                  ),
                ),
                _buildDashboardCard(
                  context: context,
                  title: 'Timeline\nđi trễ',
                  icon: Icons.timeline_rounded,
                  color: const Color(0xFF9B59B6),
                  onTap: () => context.pushNamed(timelineRouteName),
                ),
                _buildDashboardCard(
                  context: context,
                  title: 'Tải file\nExcel',
                  icon: Icons.file_download_rounded,
                  color: const Color(0xFFE74C3C),
                  onTap: () async {
                    //lấy data điểm danh
                    final data = context.read<AttendanceBloc>().state.data;
                    //xuất file excel
                    final createExcel = await ExcelServices()
                        .createExcelAttendanceFile(
                            data: data, fileName: 'Lịch sử điểm danh');
                    if (createExcel != null) {
                      if (context.mounted) {
                        ScaffoldMessengerUtils.success(
                          context,
                          'File đã được lưu tại: $createExcel',
                        );
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessengerUtils.error(
                          context,
                          'Lỗi khi tạo file Excel',
                        );
                      }
                    }
                  },
                ),
              ]),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildDashboardCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: color.withOpacity(0.1),
          highlightColor: color.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 35, color: color),
                ),
                const Spacer(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D3142),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

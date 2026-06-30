import 'package:facepass/core/utils/permission_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/router_app.dart';
import '../../../auth/presentation/blocs/auth/auth_bloc.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({super.key});

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
            backgroundColor: AppColors.primaryColor,
            title: Text(
              'Manager',
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
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

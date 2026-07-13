import 'dart:convert';

import 'package:facepass/core/utils/permission_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/router_app.dart';
import '../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../../data/datasource/remote/faces_datasource.dart';
import '../../data/repositories/recognized_repository_impl.dart';
import '../../domain/usecase/registed_face.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RegistedFace registedFace = RegistedFace(
    recognizedRepository: RecognizedRepositoryImpl(
      remoteDataSource: FacesRemoteDataSource(),
    ),
  );

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  void _requestLocationPermission() {
    PermissionUtils.requestLocationPermissions().then((granted) {
      if (!granted && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng cấp quyền vị trí để sử dụng ứng dụng'),
          ),
        );
      }
    });
  }

  void _openRegisterFace() {
    final user = context.read<AuthBloc>().state.user;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng đăng nhập lại')),
      );
      context.goNamed(loginRouteName);
      return;
    }

    context.pushNamed(
      cameraRouteName,
      extra: {
        'index': 1,
        'user': user,
      },
    );
  }

  Future<void> _showRegisteredFace() async {
    final user = context.read<AuthBloc>().state.user;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng đăng nhập lại')),
      );
      context.goNamed(loginRouteName);
      return;
    }

    final result = await registedFace.callGetRegistedFaceByUserId(user.id);
    if (!mounted) return;

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (face) {
        final imageBase64 = face?.imageBase64;
        if (imageBase64 == null || imageBase64.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Chưa có ảnh khuôn mặt để hiển thị'),
            ),
          );
          return;
        }

        final imageBytes = base64Decode(imageBase64);
        showDialog<void>(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: const Text('Ảnh khuôn mặt đã đăng ký'),
              content: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(
                  imageBytes,
                  fit: BoxFit.cover,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Đóng'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 56,
            floating: true,
            snap: true,
            backgroundColor: AppColors.primary,
            title: const Text(
              'User',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  context.read<AuthBloc>().add(AuthReset());
                  context.goNamed(loginRouteName);
                },
              ),
            ],
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HomeActionButton(
                    text: 'Đăng ký khuôn mặt',
                    onPressed: _openRegisterFace,
                  ),
                  const SizedBox(height: 20),
                  _HomeActionButton(
                    text: 'Xem ảnh khuôn mặt đã đăng ký',
                    onPressed: _showRegisteredFace,
                    outlined: true,
                  ),
                  const SizedBox(height: 20),
                  _HomeActionButton(
                    text: 'Chấm công',
                    onPressed: () {
                      context.pushNamed(
                        cameraRouteName,
                        extra: {
                          'index': 2,
                          'user': context.read<AuthBloc>().state.user,
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool outlined;

  const _HomeActionButton({
    required this.text,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    );
    const color = Color(0xFF2d6a4f);

    if (outlined) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            side: const BorderSide(color: color),
            shape: shape,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: color),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: shape,
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}

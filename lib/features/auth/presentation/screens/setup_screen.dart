import 'package:facepass/core/constants/app_colors.dart';
import 'package:facepass/core/router/router_app.dart';
import 'package:facepass/core/widgets/label_cus.dart' show LabelCus;
import 'package:facepass/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/button_cus.dart';
import '../../../../core/widgets/text_field_cus.dart';
import '../blocs/auth/auth_bloc.dart';

class SetupScreen extends StatelessWidget {
  final User user;
  SetupScreen({super.key, required this.user});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  void _handleSetup(BuildContext context) {
    final userUpdate = User(
      id: user.id,
      email: user.email,
      password: _passwordController.text,
      name: _nameController.text,
      phoneNumber: _phoneController.text,
      department: _departmentController.text,
      role: user.role,
      createdAt: user.createdAt,
    );
    context.read<AuthBloc>().add(AuthUpdate(user: userUpdate));

    FocusScope.of(context).unfocus();
  }

  //clear textfield
  void _clearTextFields() {
    _passwordController.clear();
    _confirmPasswordController.clear();
    _nameController.clear();
    _phoneController.clear();
    _departmentController.clear();
  }

  //lắng nghe sự kiện khi cập nhật thông tin thành công hay thất bại
  Widget _buildBlocListener({required Widget child}) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.updateSuccess) {
          _clearTextFields();
          context.goNamed(cameraRouteName, extra: {
            'index': 1,
            'user': state.user,
          });
        } else if (state.status == AuthStatus.error) {
          // Xử lý khi cập nhật thông tin thất bại
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(state.errorMessage ?? 'Cập nhật thông tin thất bại')),
          );
        }
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBlocListener(
      child: Scaffold(
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
                'Cập nhật thông tin',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            //body
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const LabelCus(text: 'Mật khẩu'),
                    const SizedBox(height: 8),
                    TextFieldCus(
                        width: double.infinity,
                        height: 50,
                        borderRadius: 8,
                        controller: _passwordController,
                        hintText: 'Nhập mật khẩu',
                        obscureText: true),
                    const SizedBox(height: 16),
                    const LabelCus(text: 'Xác nhận mật khẩu'),
                    const SizedBox(height: 8),
                    TextFieldCus(
                        width: double.infinity,
                        height: 50,
                        borderRadius: 8,
                        controller: _confirmPasswordController,
                        hintText: 'Xác nhận mật khẩu',
                        obscureText: true),
                    const SizedBox(height: 16),
                    const LabelCus(text: 'Họ và tên'),
                    const SizedBox(height: 8),
                    TextFieldCus(
                        width: double.infinity,
                        height: 50,
                        borderRadius: 8,
                        controller: _nameController,
                        hintText: 'Nhập họ và tên'),
                    const SizedBox(height: 16),
                    const LabelCus(text: 'Số điện thoại'),
                    const SizedBox(height: 8),
                    TextFieldCus(
                        width: double.infinity,
                        height: 50,
                        controller: _phoneController,
                        borderRadius: 8,
                        hintText: 'Nhập số điện thoại'),
                    const SizedBox(height: 16),
                    const LabelCus(text: 'Phòng ban'),
                    const SizedBox(height: 8),
                    TextFieldCus(
                        width: double.infinity,
                        height: 50,
                        borderRadius: 8,
                        controller: _departmentController,
                        hintText: 'Nhập phòng ban'),
                    const SizedBox(height: 24),
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                      return ButtonCus(
                          isLoading: state.status == AuthStatus.loading,
                          text: 'Tiếp tục',
                          width: double.infinity,
                          height: 50,
                          onPressed: () => _handleSetup(context),
                          backgroundColor: AppColors.primaryColor,
                          textStyle: const TextStyle(color: Colors.white));
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

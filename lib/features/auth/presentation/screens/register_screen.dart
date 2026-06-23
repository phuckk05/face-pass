import 'package:facepass/core/widgets/button_cus.dart';
import 'package:facepass/core/widgets/text_field_cus.dart';
import 'package:facepass/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/label_cus.dart';
import '../blocs/auth/auth_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  void _checkEmailExists(BuildContext context) async {
    context
        .read<AuthBloc>()
        .add(AuthCheckEmailExists(email: _emailController.text));
    //tắt bàn phím
    FocusScope.of(context).unfocus();
  }

  void _handleRegister(BuildContext context) {
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      phoneNumber: _phoneController.text,
      department: _departmentController.text,
      role: 'user',
      createdAt: DateTime.now(),
    );

    context.read<AuthBloc>().add(AuthRegister(user: user));
  }

  //bloc để lắng nghe trạng thái đăng ký
  Widget _buildBlocListener({required Widget child}) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.registerSuccess) {
          // Xử lý khi đăng ký thành công
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng ký thành công!')),
          );
          //clear textfield
          _emailController.clear();
          _passwordController.clear();
          _confirmPasswordController.clear();
          _nameController.clear();
          _phoneController.clear();
          _departmentController.clear();
        }
        if (state.status == AuthStatus.error) {
          // Xử lý khi đăng ký thất bại
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đăng ký thất bại: ${state.errorMessage}')),
          );
        }
        if (state.status == AuthStatus.emailExists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Email đã tồn tại')),
          );
        }
        if (state.status == AuthStatus.emailAvailable) {
          _handleRegister(context);
        }
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBlocListener(
      child: PopScope(
          canPop: true,
          child: Scaffold(
              body: CustomScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverAppBar(
                titleSpacing: 0,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {}),
                expandedHeight: 56,
                floating: true,
                snap: true,
                // pinned: false,
                // elevation: AppValues.cardElevation,
                backgroundColor: AppColors.primaryColor,
                title: Text(
                  'Đăng ký tài khoản',
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
                      const LabelCus(text: 'Email'),
                      const SizedBox(height: 8),
                      TextFieldCus(
                          width: double.infinity,
                          height: 50,
                          borderRadius: 8,
                          controller: _emailController,
                          hintText: 'Nhập email'),
                      const SizedBox(height: 16),
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
                      ButtonCus(
                          isLoading: false,
                          text: 'Đăng ký',
                          width: double.infinity,
                          height: 50,
                          onPressed: () => _checkEmailExists(context),
                          backgroundColor: AppColors.primaryColor,
                          textStyle: const TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ],
          ))),
    );
  }
}

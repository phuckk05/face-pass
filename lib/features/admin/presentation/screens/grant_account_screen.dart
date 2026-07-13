import 'package:facepass/core/utils/scaffold_messenger_utils.dart';
import 'package:facepass/core/widgets/button_cus.dart';
import 'package:facepass/features/auth/data/data_source/users_datasource.dart';
import 'package:facepass/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../core/widgets/label_cus.dart';
import '../../../../core/widgets/text_field_cus.dart';
import '../../../auth/data/repository/user_repository_impl.dart';
import '../../../auth/domain/usecase/user_usecase.dart';
import '../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../cubits/role_cubit.dart';
import '../widgets/drop_box_cus.dart';

// ignore: must_be_immutable
class GrantAccountScreen extends StatelessWidget {
  GrantAccountScreen({super.key});

  UserUsecase userUsecase = UserUsecase(
      userRepository:
          UserRepositoryImpl(userDatasource: UserAuthRemoteDatasource()));

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _validateInputs(BuildContext context) {
    if (!ValidationUtils.isValidEmail(_emailController.text)) {
      ScaffoldMessengerUtils.error(context, 'Email không hợp lệ');
      return false;
    }
    if (!ValidationUtils.isValidPassword(
        _passwordController.text, _passwordController.text)) {
      ScaffoldMessengerUtils.error(context, 'Mật khẩu không hợp lệ');
      return false;
    }
    return true;
  }

  void _handleGrantAccount(BuildContext context) async {
    //validate
    if (!_validateInputs(context)) {
      return;
    }

    //kiểm tra email đã tồn tại chưa
    await userUsecase.checkEmailExists(_emailController.text).then((result) {
      result.fold(
        (failure) {
          ScaffoldMessengerUtils.error(context, failure.message);
          return;
        },
        (exists) {
          if (exists) {
            ScaffoldMessengerUtils.error(context, 'Email đã tồn tại');
            return;
          }
        },
      );
    });

    context
        .read<AuthBloc>()
        .add(AuthCheckEmailExists(email: _emailController.text));

    final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: '',
        email: _emailController.text,
        role: context.read<RoleCubit>().state,
        avatarUrl: '',
        department: '',
        phoneNumber: '',
        password: _passwordController.text,
        createdAt: DateTime.now());

    context.read<AuthBloc>().add(AuthRegister(user: user));
    // Clear textfield
    _emailController.clear();
    _passwordController.clear();
  }

  //lằng nghe sự kiện khi cấp tài khoản thành công hay thất bại
  Widget _buildBlocListener({required Widget child}) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.registerSuccess) {
          // Xử lý khi cấp tài khoản thành công
          ScaffoldMessengerUtils.success(context, 'Cấp tài khoản thành công!');
        } else if (state.status == AuthStatus.error) {
          // Xử lý khi cấp tài khoản thất bại
          ScaffoldMessengerUtils.error(
              context, state.errorMessage ?? 'Cấp tài khoản thất bại');
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
              titleSpacing: 0,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    context.pop();
                  }),
              expandedHeight: 56,
              floating: true,
              snap: true,
              // pinned: false,
              // elevation: AppValues.cardElevation,
              backgroundColor: AppColors.primary,
              title: Text(
                'Cấp tài khoản',
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
                    LabelCus(text: 'Vai trò'),
                    const SizedBox(height: 8),
                    BlocBuilder<RoleCubit, String>(
                      builder: (context, role) {
                        return DropBoxCus(selectedValue: role);
                      },
                    ),
                    const SizedBox(height: 16),
                    LabelCus(text: 'Email'),
                    const SizedBox(height: 8),
                    TextFieldCus(
                        width: double.infinity,
                        height: 50,
                        borderRadius: 8,
                        controller: _emailController,
                        hintText: 'Nhập email'),
                    const SizedBox(height: 16),
                    LabelCus(text: 'Mật khẩu'),
                    const SizedBox(height: 8),
                    TextFieldCus(
                        width: double.infinity,
                        height: 50,
                        borderRadius: 8,
                        controller: _passwordController,
                        hintText: 'Nhập mật khẩu'),
                    const SizedBox(height: 16),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return ButtonCus(
                          isLoading: state.status == AuthStatus.loading,
                          text: 'Cấp tài khoản',
                          width: double.infinity,
                          backgroundColor: AppColors.primary,
                          height: 50,
                          textColor: AppColors.primaryLight,
                          onPressed: () => _handleGrantAccount(context),
                          textStyle: const TextStyle(color: Colors.white),
                        );
                      },
                    )
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

import 'package:facepass/core/constants/app_colors.dart';
import 'package:facepass/core/router/router_app.dart';
import 'package:facepass/core/utils/scaffold_messenger_utils.dart';
import 'package:facepass/core/widgets/button_cus.dart';
import 'package:facepass/core/widgets/text_field_cus.dart';
import 'package:facepass/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/failrue.dart';
import '../../../../core/widgets/label_cus.dart';
import '../../../face_verification/data/datasource/remote/faces_datasource.dart';
import '../../../face_verification/data/repositories/recognized_repository_impl.dart';
import '../../../face_verification/domain/usecase/registed_face.dart';
import '../blocs/auth/auth_bloc.dart';
import '../cubits/password_visibility_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final RegistedFace registedFace = RegistedFace(
    recognizedRepository: RecognizedRepositoryImpl(
      remoteDataSource: FacesRemoteDataSource(),
    ),
  );

  //Hàm xử lý đăng nhập
  void _handleLogin(String email, String password, BuildContext context) {
    context.read<AuthBloc>().add(AuthLogin(email: email, password: password));
    //tắt bàn phím
    FocusScope.of(context).unfocus();
  }

  //Hàm xử lý bấm hiện mật khẩu
  void _togglePasswordVisibility(BuildContext context) {
    context.read<PasswordVisibilityCubit>().togglePasswordVisibility();
  }

  //lắng nghe sự kiện khi đăng nhập thành công hay thất bại
  Widget _buildBlocListener({required Widget child}) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // Xử lý khi đăng nhập thành công
        if (state.status == AuthStatus.loginSuccess) {
          if (state.user == null) return;
          //kiểm tra role để điều hướng
          switch (state.user?.role) {
            case 'admin':
              _loginAsAdmin(context, state.user!);
              break;
            case 'staff':
              _loginAsStaff(context, state.user!);
              break;
            case 'manager':
              _loginAsManager(context, state.user!);
              break;

            default:
          }
        } else if (state.status == AuthStatus.error) {
          // Xử lý khi đăng nhập thất bại
          ScaffoldMessengerUtils.error(
              context, state.errorMessage ?? 'Đăng nhập thất bại');
        }
      },
      child: child,
    );
  }

  void _loginAsStaff(BuildContext context, User user) async {
    final hasSetup = user.name.isEmpty;

    //nếu đã setup thì vào home, nếu chưa setup thì vào setup
    if (hasSetup) {
      context.goNamed(setupRouteName, extra: {'user': user});
    } else {
      final hasFaceRegistered = await _checkHasFaceRegistered(context, user);
      switch (hasFaceRegistered) {
        case true:
          context.goNamed(homeRouteName, extra: {'user': user});
          break;
        case false:
          context.goNamed(cameraRouteName, extra: {'user': user, 'index': 1});
          break;
        case null:
          ScaffoldMessengerUtils.error(context, 'Đã xảy ra lỗi thử lại sau');
          return;
      }
    }
  }

  void _loginAsAdmin(BuildContext context, User user) {
    final hasSetup = user.name.isEmpty;

    if (hasSetup) {
      context.goNamed(setupRouteName, extra: {'user': user});
    } else {
      context.goNamed(adminHomeRouteName, extra: {'user': user});
    }
  }

  void _loginAsManager(BuildContext context, User user) async {
    final hasSetup = user.name.isEmpty;

    if (hasSetup) {
      context.goNamed(setupRouteName, extra: {'user': user});
    } else {
      final hasFaceRegistered = await _checkHasFaceRegistered(context, user);
      switch (hasFaceRegistered) {
        case true:
          context.goNamed(managerHomeRouteName, extra: {'user': user});
          break;
        case false:
          context.goNamed(cameraRouteName, extra: {'user': user, 'index': 1});
          break;
        case null:
          ScaffoldMessengerUtils.error(context, 'Đã xảy ra lỗi thử lại sau');
          return;
      }
    }
  }

  Future<bool?> _checkHasFaceRegistered(BuildContext context, User user) async {
    //kiểm tra xem user đã đăng kí khuôn mặt chưa
    final hasRegistedFace =
        await registedFace.callGetRegistedFaceByUserId(user.id);

    return hasRegistedFace.fold(
      (l) {
        switch (l) {
          case TimeoutFailure():
            ScaffoldMessengerUtils.error(context, 'Thử lại sau');
            break;
          default:
            ScaffoldMessengerUtils.error(context, 'Đã xảy ra lỗi thử lại sau');
        }
        return null;
      },
      (r) {
        if (r == null) {
          debugPrint('Chưa đăng kí khuôn mặt, chuyển sang camera');
          context.goNamed(cameraRouteName, extra: {'user': user, 'index': 1});
          return false;
        }
        return true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //icon ẩn hiện mật khẩu
    Widget iconVisible(bool isVisible, BuildContext context) => IconButton(
          onPressed: () => _togglePasswordVisibility(context),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.progressColor.withOpacity(0.5),
          ),
        );

    return BlocProvider(
      create: (_) => PasswordVisibilityCubit(),
      child: _buildBlocListener(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Text(
                      'GENXPKS',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 32),
                    const LabelCus(text: 'Email'),
                    const SizedBox(height: 8),
                    TextFieldCus(
                        width: double.infinity,
                        height: 50,
                        borderRadius: 8,
                        hintText: 'Nhập email',
                        textInputType: TextInputType.emailAddress,
                        controller: _emailController),
                    const SizedBox(height: 16),
                    const LabelCus(text: 'Mật khẩu'),
                    const SizedBox(height: 8),
                    BlocBuilder<PasswordVisibilityCubit, bool>(
                      builder: (context, isVisible) {
                        return TextFieldCus(
                          width: double.infinity,
                          height: 50,
                          borderRadius: 8,
                          hintText: 'Nhập mật khẩu',
                          obscureText: !isVisible,
                          controller: _passwordController,
                          suffixIcon: iconVisible(isVisible, context),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return ButtonCus(
                            onPressed: () {
                              _handleLogin(_emailController.text,
                                  _passwordController.text, context);
                            },
                            isLoading: state.status == AuthStatus.loading,
                            text: 'Đăng nhập',
                            width: double.infinity,
                            height: 50,
                            textStyle: const TextStyle(fontSize: 16));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

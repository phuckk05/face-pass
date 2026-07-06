import 'package:facepass/core/constants/app_colors.dart';
import 'package:facepass/core/utils/scaffold_messenger_utils.dart';
import 'package:facepass/core/utils/validation_utils.dart';
import 'package:facepass/core/widgets/label_cus.dart' show LabelCus;
import 'package:facepass/features/admin/domain/entities/user.dart' as UserAdmin;
import 'package:facepass/features/admin/presentation/blocs/users/users_bloc.dart';
import 'package:facepass/features/admin/presentation/cubits/role_cubit.dart';
import 'package:facepass/features/admin/presentation/widgets/drop_box_cus.dart';
import 'package:facepass/features/auth/data/data_source/users_datasource.dart';
import 'package:facepass/features/auth/data/repository/user_repository_impl.dart';
import 'package:facepass/features/auth/domain/usecase/user_usecase.dart';
import 'package:facepass/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/button_cus.dart';
import '../../../../core/widgets/text_field_cus.dart';
import '../../../auth/domain/entities/user.dart' as UserAuth;
import '../../../face_verification/data/datasource/remote/faces_datasource.dart';
import '../../../face_verification/data/repositories/recognized_repository_impl.dart';
import '../../../face_verification/domain/usecase/registed_face.dart';

class UpdateScreen extends StatefulWidget {
  final UserAdmin.User user;
  const UpdateScreen({super.key, required this.user});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  UserUsecase userUsecase = UserUsecase(
      userRepository:
          UserRepositoryImpl(userDatasource: UserAuthRemoteDatasource()));

  late final TextEditingController _emailController =
      TextEditingController(text: widget.user.email);

  late final TextEditingController _passwordController =
      TextEditingController(text: widget.user.password);

  late final TextEditingController _confirmPasswordController =
      TextEditingController(text: widget.user.password);

  late final TextEditingController _nameController =
      TextEditingController(text: widget.user.name);

  late final TextEditingController _phoneController =
      TextEditingController(text: widget.user.phoneNumber);

  late final TextEditingController _departmentController =
      TextEditingController(text: widget.user.department);

  final RegistedFace registedFace = RegistedFace(
    recognizedRepository: RecognizedRepositoryImpl(
      remoteDataSource: FacesRemoteDataSource(),
    ),
  );

  bool _validateInputs(BuildContext context) {
    if (!ValidationUtils.isValidEmail(_emailController.text)) {
      ScaffoldMessengerUtils.error(context, 'Email không hợp lệ');
      return false;
    }
    if (!ValidationUtils.isValidPassword(
        _passwordController.text, _confirmPasswordController.text)) {
      ScaffoldMessengerUtils.error(
          context, 'Mật khẩu không hợp lệ hoặc không khớp');
      return false;
    }
    if (!ValidationUtils.isValidName(_nameController.text)) {
      ScaffoldMessengerUtils.error(context, 'Họ và tên không hợp lệ');
      return false;
    }
    if (!ValidationUtils.isValidPhoneNumber(_phoneController.text)) {
      ScaffoldMessengerUtils.error(context, 'Số điện thoại không hợp lệ');
      return false;
    }
    if (!ValidationUtils.isValidDepartment(_departmentController.text)) {
      ScaffoldMessengerUtils.error(context, 'Phòng ban không hợp lệ');
      return false;
    }
    return true;
  }

  void _handleSetup(BuildContext context) async {
    FocusScope.of(context).unfocus();
    //ko cho thay đổi role chính bản thân admin
    if (widget.user.id == context.read<AuthBloc>().state.user?.id &&
        context.read<RoleCubit>().state != widget.user.role) {
      ScaffoldMessengerUtils.error(
          context, 'Không thể thay đổi vai trò của chính bạn');
      return;
    }
    //validate
    if (!_validateInputs(context)) {
      return;
    }

    //kiểm email nếu ko thay đổi
    if (_emailController.text == widget.user.email) {
      final userUpdate = UserAuth.User(
        id: widget.user.id,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        phoneNumber: _phoneController.text,
        department: _departmentController.text,
        role: context.read<RoleCubit>().state,
        createdAt: widget.user.createdAt,
      );
      context.read<AuthBloc>().add(AuthUpdate(user: userUpdate));
      return;
    }

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
          final userUpdate = UserAuth.User(
            id: widget.user.id,
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text,
            phoneNumber: _phoneController.text,
            department: _departmentController.text,
            role: context.read<RoleCubit>().state,
            createdAt: widget.user.createdAt,
          );
          context.read<AuthBloc>().add(AuthUpdate(user: userUpdate));
        },
      );
    });
  }

  //clear textfield
  void _clearTextFields() {
    _emailController.clear();
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
          ScaffoldMessengerUtils.success(
              context, 'Cập nhật thông tin thành công');
          context.pop();
          context.read<UsersBloc>().add(GetAllUsersEvent());
          // _loginAsUser(context, state.user!);
        } else if (state.status == AuthStatus.error) {
          // Xử lý khi cập nhật thông tin thất bại
          ScaffoldMessengerUtils.error(
              context, state.errorMessage ?? 'Cập nhật thông tin thất bại');
        }
      },
      child: child,
    );
  }

  @override
  void initState() {
    context.read<RoleCubit>().updateRole(widget.user.role);
    super.initState();
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
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              snap: true,
              leading: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white)),
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
                    const LabelCus(text: 'Email'),
                    const SizedBox(height: 8),
                    TextFieldCus(
                        width: double.infinity,
                        height: 50,
                        borderRadius: 8,
                        controller: _emailController,
                        hintText: 'Nhập email',
                        obscureText: false),
                    const SizedBox(height: 16),
                    const LabelCus(text: 'Vai trò'),
                    const SizedBox(height: 8),
                    BlocBuilder<RoleCubit, String>(
                      builder: (context, role) {
                        return DropBoxCus(selectedValue: role);
                      },
                    ),
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
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                      return ButtonCus(
                          isLoading: state.status == AuthStatus.loading,
                          text: 'Cập nhật thông tin',
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

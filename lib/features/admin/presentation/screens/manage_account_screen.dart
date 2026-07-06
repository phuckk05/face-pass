import 'package:facepass/core/constants/app_colors.dart';
import 'package:facepass/core/router/router_app.dart';
import 'package:facepass/core/utils/scaffold_messenger_utils.dart';
import 'package:facepass/core/widgets/dialog_cus.dart';
import 'package:facepass/features/admin/domain/entities/user.dart';
import 'package:facepass/features/admin/presentation/blocs/users/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ManageAccountScreen extends StatelessWidget {
  const ManageAccountScreen({super.key});

  //build lắng nghe sự kiện xóa tài khoản
  Widget _buildBlocListener({required Widget child}) {
    return BlocListener<UsersBloc, UsersState>(
      listener: (context, state) {
        switch (state.status) {
          case UsersStateStatus.loading:
            break;
          case UsersStateStatus.success:
            if (state.action == UsersAction.delete) {
              ScaffoldMessengerUtils.success(
                  context, 'Xóa tài khoản thành công');
            }
            break;
          case UsersStateStatus.error:
            if (state.action == UsersAction.delete) {
              ScaffoldMessengerUtils.error(
                  context, state.message ?? 'Đã xảy ra lỗi');
            }
            break;
          case UsersStateStatus.initial:
            break;
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
              pinned: true,
              // elevation: AppValues.cardElevation,
              backgroundColor: AppColors.primaryColor,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
              title: Text(
                'Quản lý tài khoản',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            //body
            BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
              if (state.status == UsersStateStatus.loading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state.status == UsersStateStatus.error) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          state.message ?? 'Đã xảy ra lỗi',
                          style: const TextStyle(color: Colors.red),
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            context.read<UsersBloc>().add(GetAllUsersEvent());
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final user = state.users[index];

                      return Dismissible(
                        key: ValueKey(user.email),
                        direction: DismissDirection.endToStart,

                        // Nền hiện khi vuốt
                        background: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.only(right: 20),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),

                        // Hỏi trước khi xóa
                        confirmDismiss: (_) async {
                          return await DialogCus.showConfirm(
                              context: context,
                              title: "Xóa tài khoản",
                              message:
                                  "Bạn có chắc muốn xóa tài khoản này không?");
                        },

                        onDismissed: (_) {
                          context
                              .read<UsersBloc>()
                              .add(DeleteUserEvent(id: user.id));
                        },

                        child: _buildItemAccount(user, context),
                      );
                    },
                    childCount: state.users.length,
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  //item
  Widget _buildItemAccount(User user, BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      onTap: () {
        context.pushNamed(updateAccountRouteName, extra: {'user': user});
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Row(
          children: [
            //image
            FittedBox(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  color: Colors.grey[300],
                ),
                child: const Icon(Icons.person, size: 40, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            //info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.role,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            //actions
            // IconButton(
            //   icon: const Icon(Icons.delete, color: Colors.red),
            //   onPressed: () {
            //     // Handle delete action
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

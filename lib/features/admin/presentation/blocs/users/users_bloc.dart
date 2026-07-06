import 'package:facepass/features/admin/domain/entities/user.dart';
import 'package:facepass/features/admin/domain/usecase/user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_event.dart';
part 'users_state.dart';
part 'users_bloc.freezed.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserAdminUsecase userAdminUsecase;
  UsersBloc({required this.userAdminUsecase}) : super(const UsersState()) {
    on<GetAllUsersEvent>(_getAllUsers);
    on<DeleteUserEvent>(_deleteUser);
    on<UpdateUserEvent>(_updateUser);
  }
  void _getAllUsers(GetAllUsersEvent event, Emitter<UsersState> emit) async {
    emit(state.copyWith(
        status: UsersStateStatus.loading, action: UsersAction.getAll));
    try {
      final users = await userAdminUsecase.getAllUsers();
      users.fold(
        (failure) {
          emit(state.copyWith(
              users: [],
              status: UsersStateStatus.error,
              message: failure.message));
        },
        (users) {
          emit(state.copyWith(status: UsersStateStatus.success, users: users));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          users: [], status: UsersStateStatus.error, message: e.toString()));
    }
  }

  void _deleteUser(DeleteUserEvent event, Emitter<UsersState> emit) async {
    emit(state.copyWith(
        status: UsersStateStatus.loading, action: UsersAction.delete));
    try {
      final result = await userAdminUsecase.deleteUser(event.id);
      result.fold(
        (failure) {
          emit(state.copyWith(
              status: UsersStateStatus.error, message: failure.message));
        },
        (isSuccess) {
          if (isSuccess) {
            add(GetAllUsersEvent());
          } else {
            emit(state.copyWith(
                status: UsersStateStatus.error,
                message: 'Xóa tài khoản thất bại'));
          }
        },
      );
    } catch (e) {
      emit(state.copyWith(
          status: UsersStateStatus.error, message: e.toString()));
    }
  }

  void _updateUser(UpdateUserEvent event, Emitter<UsersState> emit) async {
    emit(state.copyWith(
        status: UsersStateStatus.loading, action: UsersAction.update));
    try {
      final result = await userAdminUsecase.updateUser(event.user);
      result.fold(
        (failure) {
          emit(state.copyWith(
              status: UsersStateStatus.error, message: failure.message));
        },
        (isSuccess) {
          if (isSuccess) {
            add(GetAllUsersEvent());
          } else {
            emit(state.copyWith(
                status: UsersStateStatus.error,
                message: 'Cập nhật tài khoản thất bại'));
          }
        },
      );
    } catch (e) {
      emit(state.copyWith(
          status: UsersStateStatus.error, message: e.toString()));
    }
  }
}

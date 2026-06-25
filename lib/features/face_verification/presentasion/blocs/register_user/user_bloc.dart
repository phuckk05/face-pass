import 'package:facepass/features/face_verification/domain/usecase/resgister_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/user.dart';

part 'user_bloc.freezed.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final RegisterUserUseCase registerUserUseCase;
  UserBloc({required this.registerUserUseCase})
      : super(const UserState.initial()) {
    // on<RegisterUserEvent>(_registerUser);
    on<GetUserByIdEvent>(_getUserById);
  }

  //đăng kí người dùng mới
  // Future<void> _registerUser(
  //   RegisterUserEvent event,
  //   Emitter<UserState> emit,
  // ) async {
  //   emit(const UserState.loading());
  //   final result = await registerUserUseCase.callRegisterUser(
  //     event.name,
  //     event.department,
  //     event.avatarUrl,
  //   );
  //   result.fold(
  //     (failure) => emit(UserState.failed(message: failure.message)),
  //     (user) => emit(UserState.success(user: user)),
  //   );
  // }

  //lấy user theo id
  Future<void> _getUserById(
    GetUserByIdEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());
    final result = await registerUserUseCase.callGetUserById(event.id);
    result.fold(
      (failure) => emit(UserState.failed(message: failure.message)),
      (user) {
        if (user == null) {
          emit(const UserState.failed(message: 'Không tìm thấy người dùng'));
        } else {
          emit(UserState.success(user: user));
        }
      },
    );
  }
}

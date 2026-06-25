import 'package:facepass/features/auth/domain/usecase/user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facepass/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserUsecase userUsecase;
  AuthBloc({required this.userUsecase}) : super(const AuthState()) {
    on<AuthLogin>(_handleLogin);
    on<AuthRegister>(_handleRegister);
    on<AuthCheckEmailExists>(checkEmailExists);
    on<AuthReset>(_reset);
    on<AuthUpdate>(updateUser);
  }

  //login
  Future<void> _handleLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    //delay 3 giây
    await Future.delayed(const Duration(seconds: 3));
    try {
      final user = await userUsecase.loginUser(event.email, event.password);
      user.fold(
        (failure) {
          emit(state.copyWith(
              user: null,
              status: AuthStatus.error,
              errorMessage: failure.message));
        },
        (uesr) {
          emit(state.copyWith(status: AuthStatus.loginSuccess, user: uesr));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          user: null, status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  //register
  Future<void> _handleRegister(
      AuthRegister event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    //delay 3 giây
    await Future.delayed(const Duration(seconds: 3));
    try {
      final user = await userUsecase.registerUser(event.user);
      user.fold(
        (failure) {
          emit(state.copyWith(
              user: null,
              status: AuthStatus.error,
              errorMessage: failure.message));
        },
        (user) {
          emit(state.copyWith(status: AuthStatus.registerSuccess, user: user));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          user: null, status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  //check email exists
  Future<void> checkEmailExists(
      AuthCheckEmailExists event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final exists = await userUsecase.checkEmailExists(event.email);
      exists.fold(
        (failure) {
          emit(state.copyWith(
              status: AuthStatus.error, errorMessage: failure.message));
        },
        (exists) {
          if (exists) {
            emit(state.copyWith(
                status: AuthStatus.emailExists,
                errorMessage: '${event.email} đã tồn tại.'));
          } else {
            emit(state.copyWith(status: AuthStatus.emailAvailable));
          }
        },
      );
    } catch (e) {
      emit(
          state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
      debugPrint('Lỗi: ${e.toString()}');
    }
  }

  //reset data
  void _reset(AuthReset event, Emitter<AuthState> emit) {
    emit(const AuthState());
  }

  //update user
  Future<void> updateUser(AuthUpdate event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final success = await userUsecase.updateUser(event.user);

      success.fold(
          (failure) => {
                emit(state.copyWith(
                    status: AuthStatus.error, errorMessage: failure.message))
              }, (success) {
        emit(
            state.copyWith(status: AuthStatus.updateSuccess, user: event.user));
      });
    } catch (e) {
      emit(
          state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }
}

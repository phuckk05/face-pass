part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  loginSuccess,
  registerSuccess,
  logoutSuccess,
  updateSuccess,
  emailExists,
  emailAvailable,
  success,
  error,
}

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(null) User? user,
    @Default(AuthStatus.initial) AuthStatus status,
    String? errorMessage,
  }) = _AuthState;
}

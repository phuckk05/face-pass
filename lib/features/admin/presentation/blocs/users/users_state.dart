part of 'users_bloc.dart';

enum UsersStateStatus { initial, loading, success, error }

enum UsersAction { none, delete, update, getAll }

@freezed
abstract class UsersState with _$UsersState {
  const factory UsersState({
    @Default([]) List<User> users,
    @Default(UsersStateStatus.initial) UsersStateStatus status,
    @Default(UsersAction.none) UsersAction action,
    String? message,
  }) = _UsersState;
}

part of 'user_bloc.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState.initial() = UserInitialState;
  const factory UserState.loading() = UserLoadingState;
  const factory UserState.success({required User user}) = UserSuccessState;
  const factory UserState.failed({required String message}) = UserFailedState;
}

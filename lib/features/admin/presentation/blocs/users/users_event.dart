part of 'users_bloc.dart';

abstract class UsersEvent {}

class GetAllUsersEvent extends UsersEvent {}

class UpdateUserEvent extends UsersEvent {
  final User user;
  UpdateUserEvent({required this.user});
}

class DeleteUserEvent extends UsersEvent {
  final String id;
  DeleteUserEvent({required this.id});
}

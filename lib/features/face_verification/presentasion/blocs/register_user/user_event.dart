part of 'user_bloc.dart';

abstract class UserEvent {}

/*
lấy user theo id
*/
class GetUserByIdEvent extends UserEvent {
  final String id;
  GetUserByIdEvent({required this.id});
}

/*
* event đăng kí người dùng mới
*/
class RegisterUserEvent extends UserEvent {
  final String? name;
  final String? department;
  final String? avatarUrl;
  RegisterUserEvent({this.name, this.department, this.avatarUrl});
}

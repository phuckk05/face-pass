part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

class AuthRegister extends AuthEvent {
  final User user;

  AuthRegister({
    required this.user,
  });
}

class AuthLogout extends AuthEvent {}

class AuthCheckEmailExists extends AuthEvent {
  final String email;
  AuthCheckEmailExists({required this.email});
}

//update
class AuthUpdate extends AuthEvent {
  final User user;
  AuthUpdate({required this.user});
}

//reset data
class AuthReset extends AuthEvent {}

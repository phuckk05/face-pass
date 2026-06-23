import 'package:flutter_bloc/flutter_bloc.dart';

class RoleCubit extends Cubit<String> {
  RoleCubit() : super('user');

  void updateRole(String role) {
    emit(role);
  }
}

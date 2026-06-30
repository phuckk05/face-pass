import 'package:flutter_bloc/flutter_bloc.dart';

class RoleCubit extends Cubit<String> {
  RoleCubit() : super('staff');

  void updateRole(String role) {
    emit(role);
  }
}

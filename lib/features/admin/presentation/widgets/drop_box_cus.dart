import 'package:facepass/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/role_cubit.dart';

class DropBoxCus extends StatelessWidget {
  final String selectedValue;
  const DropBoxCus({super.key, required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.progressColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: const Text('Chọn vai trò'),
        value: selectedValue,
        items: <String>['admin', 'user'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          context.read<RoleCubit>().updateRole(newValue!);
        },
      ),
    );
  }
}

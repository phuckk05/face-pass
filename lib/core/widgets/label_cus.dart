import 'package:flutter/material.dart';

import '../constants/app_styles.dart';

class LabelCus extends StatelessWidget {
  final String text;
  const LabelCus({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: AppStyles.label),
    );
  }
}

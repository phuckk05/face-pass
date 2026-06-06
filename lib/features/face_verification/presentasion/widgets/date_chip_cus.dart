import 'package:flutter/material.dart';

class DateChipCus extends StatelessWidget {
  const DateChipCus({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
    final day = days[now.weekday % 7];
    final date =
        '$day · ${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        date,
        style: const TextStyle(
          color: Colors.white60,
          fontSize: 10,
          fontFamily: 'DM Mono',
        ),
      ),
    );
  }
}

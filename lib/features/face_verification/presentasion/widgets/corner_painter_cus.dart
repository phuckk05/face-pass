import 'package:flutter/material.dart';

class CornerPainterCus extends CustomPainter {
  final Color color;
  final double stroke;
  CornerPainterCus(this.color, this.stroke);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, size.height), Offset.zero, paint);
    canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

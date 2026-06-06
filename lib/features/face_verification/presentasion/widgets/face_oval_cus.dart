import 'package:flutter/material.dart';

import 'corner_painter_cus.dart';

class FaceOvalCus extends StatefulWidget {
  const FaceOvalCus({super.key});

  @override
  State<FaceOvalCus> createState() => _FaceOvalCusState();
}

class _FaceOvalCusState extends State<FaceOvalCus>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scanAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
    _scanAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const w = 160.0;
    const h = 260.0;

    return SizedBox(
      width: w,
      height: h,
      child: Stack(
        children: [
          //viền hinh vuông
          ..._buildCorners(w, h),

          //đường quét ngang
          AnimatedBuilder(
            animation: _scanAnim,
            builder: (_, __) {
              final top = h * 0.15 + (h * 0.7) * _scanAnim.value;
              return Positioned(
                top: top,
                left: 12,
                right: 12,
                child: Container(
                  height: 1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFF4ade80).withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Tạo 4 góc của hình oval bằng CustomPainter
  List<Widget> _buildCorners(double w, double h) {
    const size = 18.0;
    const stroke = 1.5;
    const color = Color(0xFF4ade80);

    Widget corner() => SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: CornerPainterCus(color, stroke)),
    );

    return [
      Positioned(top: 0, left: 0, child: corner()),
      Positioned(
        top: 0,
        right: 0,
        child: Transform.scale(scaleX: -1, child: corner()),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Transform.scale(scaleY: -1, child: corner()),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Transform.scale(scaleX: -1, scaleY: -1, child: corner()),
      ),
    ];
  }
}

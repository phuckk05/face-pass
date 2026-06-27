import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/router_app.dart';
import '../../../auth/domain/entities/user.dart';

class CameraScreen extends StatelessWidget {
  final int index;
  final User user;

  const CameraScreen({
    super.key,
    required this.index,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final title = index == 1 ? 'Đăng ký khuôn mặt' : 'Chấm công';

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2d6a4f),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.goNamed(homeRouteName),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.no_photography_outlined,
                  size: 56,
                  color: Color(0xFF2d6a4f),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tính năng camera và nhận diện khuôn mặt chưa hỗ trợ trên web.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => context.goNamed(homeRouteName),
                  child: const Text('Quay về trang chủ'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraCus extends StatelessWidget {
  final CameraController? controller;
  CameraCus({super.key, this.controller});

  final container = Container(
    decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200]?.withOpacity(0.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: controller != null && controller!.value.isInitialized
              ? Row(
                  children: [
                    Expanded(child: container),
                    FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: controller!.value.previewSize!.height,
                        height: controller!.value.previewSize!.width,
                        child: CameraPreview(controller!),
                      ),
                    ),
                    Expanded(child: container),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

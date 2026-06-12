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
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200]?.withOpacity(0.5)),
      child: ClipRRect(
        child: controller != null && controller!.value.isInitialized
            ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller!.value.previewSize!.height,
                  height: controller!.value.previewSize!.width,
                  // width: double.infinity,
                  // height: double.infinity,
                  child: CameraPreview(controller!),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

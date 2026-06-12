import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class CameraUtils {
  static double cosineSimilarity(List<double> a, List<double> b) {
    double dot = 0, normA = 0, normB = 0;
    for (int i = 0; i < a.length; i++) {
      dot += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }
    return dot / (sqrt(normA) * sqrt(normB));
  }

  static Future<List<double>?> recognizeIsolate(
    Map<String, dynamic> args,
  ) async {
    final path = args['path'] as String;
    final modelBytes = args['modelBytes'] as Uint8List;
    final rootIsolateToken = args['rootIsolateToken'] as RootIsolateToken;
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

    // 1. Face detection trong isolate
    final detector = FaceDetector(options: FaceDetectorOptions());
    final faces = await detector.processImage(InputImage.fromFilePath(path));
    await detector.close();
    if (faces.isEmpty) return null;

    // 2. Decode + crop + resize
    final bb = faces.first.boundingBox;
    final original = img.decodeImage(await File(path).readAsBytes());
    if (original == null) return null;

    final left = bb.left.toInt().clamp(0, original.width - 1);
    final top = bb.top.toInt().clamp(0, original.height - 1);
    final right = bb.right.toInt().clamp(left + 1, original.width);
    final bottom = bb.bottom.toInt().clamp(top + 1, original.height);

    final resized = img.copyResize(
      img.copyCrop(
        original,
        x: left,
        y: top,
        width: right - left,
        height: bottom - top,
      ),
      width: 160,
      height: 160,
    );

    final input = [
      List.generate(
        160,
        (y) => List.generate(160, (x) {
          final p = resized.getPixel(x, y);
          return [
            (p.r.toDouble() - 128.0) / 128.0,
            (p.g.toDouble() - 128.0) / 128.0,
            (p.b.toDouble() - 128.0) / 128.0,
          ];
        }),
      ),
    ];
    final output = [List.filled(128, 0.0)];

    // 4. Inference
    final interpreter = Interpreter.fromBuffer(modelBytes);
    interpreter.run(input, output);
    interpreter.close();

    return List<double>.from(output[0]);
  }

  //chuyển đổi datetime sang hh:mm:ss DD/MM/YYYY
  static String formatDateTime(String dateTime) {
    final dt = DateTime.parse(dateTime);
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')} ${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }
}

import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';

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
    return null;
  }

  static String formatDateTime(String dateTime) {
    final dt = DateTime.parse(dateTime);
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')} ${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }

  static String formatTime(String dateTime) {
    final dt = DateTime.parse(dateTime);
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
  }

  static String calculateLateTime(String dateTime) {
    final dt = DateTime.parse(dateTime);
    final lateDuration =
        dt.difference(DateTime(dt.year, dt.month, dt.day, 8, 0));
    if (lateDuration.isNegative) return '0 phut';
    return '${lateDuration.inMinutes} phut';
  }
}

class FaceRecognitionWorker {
  static Future<void> init(Uint8List modelBytes, RootIsolateToken token) async {}

  static Future<List<double>?> process(String path) async => null;
}

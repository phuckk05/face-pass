import 'dart:io';
import 'dart:isolate';
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
    return null;
  }

  //chuyển đổi datetime sang hh:mm:ss DD/MM/YYYY
  static String formatDateTime(String dateTime) {
    final dt = DateTime.parse(dateTime);
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')} ${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }

  //chuyển đổi datetime sang hh:mm:ss
  static String formatTime(String dateTime) {
    final dt = DateTime.parse(dateTime);
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
  }

  //hàm tính thời gian đi trễ so với giờ quy định (8h00)
  static String calculateLateTime(String dateTime) {
    final dt = DateTime.parse(dateTime);
    final lateDuration =
        dt.difference(DateTime(dt.year, dt.month, dt.day, 8, 0));
    if (lateDuration.isNegative) return '0 phút';
    return '${lateDuration.inMinutes} phút';
  }
}

class FaceRecognitionWorker {
  static SendPort? _sendPort;

  static Future<void> init(Uint8List modelBytes, RootIsolateToken token) async {
    if (_sendPort != null) return;
    final receivePort = ReceivePort();
    await Isolate.spawn(
        _isolateEntry, [receivePort.sendPort, modelBytes, token]);
    _sendPort = await receivePort.first as SendPort;
  }

  static Future<List<double>?> process(String path) async {
    if (_sendPort == null) return null;
    final responsePort = ReceivePort();
    _sendPort!.send([path, responsePort.sendPort]);
    return await responsePort.first as List<double>?;
  }

  static void _isolateEntry(List<dynamic> args) async {
    final SendPort sendPort = args[0];
    final Uint8List modelBytes = args[1];
    final RootIsolateToken token = args[2];
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);

    final detector = FaceDetector(options: FaceDetectorOptions());
    final interpreter = Interpreter.fromBuffer(modelBytes);

    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    await for (final message in receivePort) {
      final String path = message[0];
      final SendPort replyPort = message[1];

      try {
        final faces =
            await detector.processImage(InputImage.fromFilePath(path));
        if (faces.isEmpty) {
          replyPort.send(null);
          continue;
        }

        final bb = faces.first.boundingBox;
        final bytes = await File(path).readAsBytes();
        final original = img.decodeJpg(bytes);
        if (original == null) {
          replyPort.send(null);
          continue;
        }

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

        interpreter.run(input, output);
        replyPort.send(List<double>.from(output[0]));
      } catch (e) {
        replyPort.send(null);
      }
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

class CameraProcessCubit extends Cubit<Map<String, dynamic>> {
  CameraProcessCubit() : super({'isProcessing': false, 'isCameraReady': false});

  void setProcessing(bool isProcessing) {
    emit({
      'isProcessing': isProcessing,
      'isCameraReady': state['isCameraReady'],
    });
  }

  void setCameraReady(bool isCameraReady) {
    emit({
      'isProcessing': state['isProcessing'],
      'isCameraReady': isCameraReady,
    });
  }
}

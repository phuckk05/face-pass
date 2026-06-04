import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/camera_utils.dart';
part 'recognizing_face_bloc.freezed.dart';

part 'recognizing_face_state.dart';
part 'recognizing_face_event.dart';

class RecognizingFaceBloc
    extends Bloc<RecognizingFaceEvent, RecognizingFaceState> {
  RecognizingFaceBloc()
    : super(const RecognizingFaceState.initial(messge: null)) {
    /* 1 */
    on<InitProcessFaceEvent>(_initProcessFace);
    /* 2 */
    on<ProcessingFaceEvent>(_processFace);
  }

  //init process face event
  void _initProcessFace(
    InitProcessFaceEvent event,
    Emitter<RecognizingFaceState> emit,
  ) async {
    emit(
      const RecognizingFaceState.initial(
        messge: "Vui lòng cho khuôn mặt vào khung để nhận diện",
      ),
    );
    //bắn sự kiện đang xử lý
    emit(
      const RecognizingFaceState.processing(
        messge: "Đang nhận diện khuôn mặt...",
      ),
    );
  }

  //process face event
  void _processFace(
    ProcessingFaceEvent event,
    Emitter<RecognizingFaceState> emit,
  ) async {
    for (final vector in event.faces) {
      final similarity = CameraUtils.cosineSimilarity(
        event.newEmbedding,
        vector,
      );
      if (similarity > 0.8) {
        emit(
          RecognizingFaceState.success(
            embedding: event.newEmbedding,
            messge: "Xác minh thành công",
          ),
        );
      } else {
        emit(
          const RecognizingFaceState.failed(
            message: "Khuôn mặt không khớp, vui lòng thử lại",
          ),
        );
      }
    }
  }
}

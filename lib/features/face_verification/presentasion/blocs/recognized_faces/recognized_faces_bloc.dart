import 'package:facepass/features/face_verification/domain/entities/face_embedding%20.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/usecase/resgister_face.dart';

part 'recognized_faces_bloc.freezed.dart';
part 'recognized_faces_event.dart';
part 'recognized_faces_state.dart';

class RecognizedFacesBloc
    extends Bloc<RecognizedFacesEvent, RecognizedFacesState> {
  final RegisterFaceUseCase registerFaceUseCase;
  RecognizedFacesBloc({required this.registerFaceUseCase})
    : super(const RecognizedFacesState.initial()) {
    /* 1 */
    on<LoadRecognizedFacesEvent>(_loadRecognizedFaces);
    /* 2 */
    on<AddRecognizedFaceEvent>(_addRecognizedFace);
    /* 3 */
  }

  //1 - hàm load dữ liệu khuôn mặt đã nhận diện được
  void _loadRecognizedFaces(
    LoadRecognizedFacesEvent event,
    Emitter<RecognizedFacesState> emit,
  ) {
    add(LoadRecognizedFacesEvent());
  }

  //2 - thêm dữ liệu khuôn mặt mới vào danh sách đã nhận diện
  void _addRecognizedFace(
    AddRecognizedFaceEvent event,
    Emitter<RecognizedFacesState> emit,
  ) async {
    emit(RecognizedFacesState.loading());
    try {
      final result = await registerFaceUseCase.callRegisterFace(
        event.faceEmbedding,
      );
      if (result) {
        emit(RecognizedFacesState.success(embedding: event.faceEmbedding));
      }
    } catch (e) {
      emit(
        RecognizedFacesState.error(
          message: "Lỗi khi thêm khuôn mặt vào danh sách",
          faces: [],
        ),
      );
    }
  }
}

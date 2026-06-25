import 'package:facepass/features/face_verification/domain/entities/face_embedding.dart';
import 'package:facepass/features/face_verification/domain/usecase/registed_face.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/usecase/resgister_face.dart';

part 'recognized_faces_bloc.freezed.dart';
part 'recognized_faces_event.dart';
part 'recognized_faces_state.dart';

class RecognizedFacesBloc
    extends Bloc<RecognizedFacesEvent, RecognizedFacesState> {
  final RegisterFaceUseCase registerFaceUseCase;
  final RegistedFace registedFace;
  RecognizedFacesBloc({
    required this.registerFaceUseCase,
    required this.registedFace,
  }) : super(const RecognizedFacesState.initial()) {
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
  ) async {
    emit(RecognizedFacesState.loading());
    final result = await registedFace.callGetRegistedFaces();
    result.fold(
      (failure) => emit(
        RecognizedFacesState.error(
          message: failure.message,
          faces: [],
        ),
      ),
      (faces) => emit(RecognizedFacesState.hasData(recognizedFaces: faces)),
    );
  }

  //2 - thêm dữ liệu khuôn mặt mới vào danh sách đã nhận diện
  void _addRecognizedFace(
    AddRecognizedFaceEvent event,
    Emitter<RecognizedFacesState> emit,
  ) async {
    emit(RecognizedFacesState.loading());
    final result = await registerFaceUseCase.callRegisterFace(
      event.faceEmbedding,
    );
    result.fold(
      (failure) => emit(
        RecognizedFacesState.error(
          message: failure.message,
          faces: [],
        ),
      ),
      (success) {
        if (success) {
          emit(
            RecognizedFacesState.success(
              embedding: event.faceEmbedding,
              message: 'Thêm khuôn mặt vào danh sách thành công',
            ),
          );
        }
      },
    );
  }
}

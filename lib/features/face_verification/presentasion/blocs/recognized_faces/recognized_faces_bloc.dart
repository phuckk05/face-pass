import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recognized_faces_bloc.freezed.dart';
part 'recognized_faces_event.dart';
part 'recognized_faces_state.dart';

class RecognizedFacesBloc
    extends Bloc<RecognizedFacesEvent, RecognizedFacesState> {
  RecognizedFacesBloc() : super(const RecognizedFacesState.initial()) {
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
    final embedding = event.faceEmbedding;
    //kiểm tra nếu null thì cút
    if (embedding == null || embedding.isEmpty) return;

    final updated = [
      ...state.maybeWhen(
        hasData: (faces) => faces,
        loading: (faces) => faces,
        orElse: () => <List<double>>[],
      ),
      embedding,
    ];

    emit(RecognizedFacesState.hasData(recognizedFaces: updated));
  }
}

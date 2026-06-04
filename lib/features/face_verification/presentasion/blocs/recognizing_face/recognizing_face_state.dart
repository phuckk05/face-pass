part of 'recognizing_face_bloc.dart';

@freezed
sealed class RecognizingFaceState with _$RecognizingFaceState {
  //initial state
  const factory RecognizingFaceState.initial({required String? messge}) =
      _RecognizingFaceInitial;

  //process state
  const factory RecognizingFaceState.processing({required String messge}) =
      _RecognizingFaceProcessing;

  //process failed state
  const factory RecognizingFaceState.failed({required String message}) =
      _RecognizingFaceFailed;
  //process success state
  const factory RecognizingFaceState.success({
    required List<double> embedding,
    required String? messge,
  }) = _RecognizingFaceSuccess;
}

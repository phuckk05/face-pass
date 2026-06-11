part of 'recognizing_face_bloc.dart';

@freezed
sealed class RecognizingFaceState with _$RecognizingFaceState {
  //initial state
  const factory RecognizingFaceState.initial({required String? messge}) =
      RecognizingFaceInitial;

  //process state
  const factory RecognizingFaceState.processing({required String messge}) =
      RecognizingFaceProcessing;

  //process failed state
  const factory RecognizingFaceState.failed({required String message}) =
      RecognizingFaceFailed;
  //processing of failed
  const factory RecognizingFaceState.processingErrol({
    required String message,
  }) = RecognizingFaceProcessingErrol;
  //processing of failed
  const factory RecognizingFaceState.processingUpdate({
    required FaceEmbedding embedding,
    required String? message,
  }) = RecognizingFaceProcessingUpdate;

  //process success state
  const factory RecognizingFaceState.success({
    required FaceEmbedding embedding,
    required String? messge,
  }) = RecognizingFaceSuccess;
  //xác minh độ tương đồng thành công
  const factory RecognizingFaceState.similaritySuccess({
    required FaceEmbedding? embedding,
    required String? messge,
  }) = RecognizingFaceSimilaritySuccess;
}

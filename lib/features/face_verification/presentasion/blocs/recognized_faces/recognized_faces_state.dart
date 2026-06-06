part of 'recognized_faces_bloc.dart';

@freezed
sealed class RecognizedFacesState with _$RecognizedFacesState {
  //1- trạng thái khởi tạo
  const factory RecognizedFacesState.initial() = RecognizedFacesInitialState;

  //2- trạng thái có dữ liệu khuôn mặt đã nhận diện
  const factory RecognizedFacesState.hasData({
    required List<FaceEmbedding> recognizedFaces,
  }) = RecognizedFacesHasDataState;

  //3- trạng thái lỗi
  const factory RecognizedFacesState.error({
    String? message,
    @Default([]) List<FaceEmbedding> faces,
  }) = RecognizedFacesErrorState;

  //4- trạng thái đang tải dữ liệu
  const factory RecognizedFacesState.loading({
    @Default([]) List<FaceEmbedding> faces,
  }) = RecognizedFacesLoadingState;

  //5- trạng thái không có dữ liệu nào
  const factory RecognizedFacesState.empty() = _RecognizedFacesEmptyState;
  //6- trạng thái success khi thêm dữ liệu
  const factory RecognizedFacesState.success({
    required FaceEmbedding embedding,
  }) = RecognizedFacesSuccessState;
}

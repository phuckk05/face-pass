part of 'recognized_faces_bloc.dart';

@freezed
sealed class RecognizedFacesState with _$RecognizedFacesState {
  //1- trạng thái khởi tạo
  const factory RecognizedFacesState.initial() = _RecognizedFacesInitialState;

  //2- trạng thái có dữ liệu khuôn mặt đã nhận diện
  const factory RecognizedFacesState.hasData({
    required List<List<double>> recognizedFaces,
  }) = _RecognizedFacesHasDataState;

  //3- trạng thái lỗi
  const factory RecognizedFacesState.error({
    String? message,
    @Default([]) List<List<double>> faces,
  }) = _RecognizedFacesErrorState;

  //4- trạng thái đang tải dữ liệu
  const factory RecognizedFacesState.loading({
    @Default([]) List<List<double>> faces,
  }) = _RecognizedFacesLoadingState;

  //5- trạng thái không có dữ liệu nào
  const factory RecognizedFacesState.empty() = _RecognizedFacesEmptyState;
}

part of 'recognized_faces_bloc.dart';

abstract class RecognizedFacesEvent {}

//1- event load dữ liệu
class LoadRecognizedFacesEvent extends RecognizedFacesEvent {}

//2- event thêm dữ liệu mới vào danh sách
class AddRecognizedFaceEvent extends RecognizedFacesEvent {
  final List<double>? faceEmbedding;
  AddRecognizedFaceEvent(this.faceEmbedding);
}

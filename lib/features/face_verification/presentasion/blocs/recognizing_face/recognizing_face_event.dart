part of 'recognizing_face_bloc.dart';

abstract class RecognizingFaceEvent {}

class InitProcessFaceEvent extends RecognizingFaceEvent {}

class ProcessingFaceEvent extends RecognizingFaceEvent {
  final List<double> newEmbedding;
  final List<List<double>> faces;
  ProcessingFaceEvent({required this.newEmbedding, required this.faces});
}

// class ProcessSuccessFaceEvent extends RecognizingFaceEvent {
//   final List<double> faceEmbedding;
//   ProcessSuccessFaceEvent({required this.faceEmbedding});
// }

// class ProcessFaceFailedEvent extends RecognizingFaceEvent {
//   final String message;
//   ProcessFaceFailedEvent({required this.message});
// }

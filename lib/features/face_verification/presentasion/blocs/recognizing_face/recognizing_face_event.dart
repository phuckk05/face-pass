part of 'recognizing_face_bloc.dart';

abstract class RecognizingFaceEvent {}

class InitProcessFaceEvent extends RecognizingFaceEvent {}

class ProcessingFaceEvent extends RecognizingFaceEvent {
  final List<double>? newEmbedding;
  final int? index;
  ProcessingFaceEvent({this.newEmbedding, this.index});
}

class UpdateFaceEmbedding extends RecognizingFaceEvent {
  final List<double>? embedding;
  final int index;
  UpdateFaceEmbedding({required this.embedding, required this.index});
}

class CreateTempFaceEmbedding extends RecognizingFaceEvent {
  final String userId;
  CreateTempFaceEmbedding({required this.userId});
}

class StopVerifyingEvent extends RecognizingFaceEvent {
  final String message;
  StopVerifyingEvent({required this.message});
}

class CheckSimilarityEvent extends RecognizingFaceEvent {
  final String message;
  CheckSimilarityEvent({required this.message});
}

class PushToDatabaseEvent extends RecognizingFaceEvent {
  final FaceEmbedding embedding;
  PushToDatabaseEvent({required this.embedding});
}

//xác minh độ tương đồng thành công
class SimilaritySuccessEvent extends RecognizingFaceEvent {
  final FaceEmbedding embedding;
  final String? message;
  SimilaritySuccessEvent({required this.embedding, this.message});
}
// class ProcessSuccessFaceEvent extends RecognizingFaceEvent {
//   final List<double> faceEmbedding;
//   ProcessSuccessFaceEvent({required this.faceEmbedding});
// }

// class ProcessFaceFailedEvent extends RecognizingFaceEvent {
//   final String message;
//   ProcessFaceFailedEvent({required this.message});
// }

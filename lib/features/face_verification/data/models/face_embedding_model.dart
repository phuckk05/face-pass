import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/face_embedding .dart';

part 'face_embedding_model.freezed.dart';
part 'face_embedding_model.g.dart';

@freezed
abstract class FaceEmbeddingModel with _$FaceEmbeddingModel {
  const factory FaceEmbeddingModel({
    required String id,
    required String userId,
    required List<double> vector1,
    required List<double> vector2,
    required List<double> vector3,
    required List<double> vector4,
    required List<double> vector5,
    required DateTime registeredAt,
  }) = _FaceEmbeddingModel;

  factory FaceEmbeddingModel.fromJson(Map<String, dynamic> json) =>
      _$FaceEmbeddingModelFromJson(json);
}

//các extension để chuyển đổi giữa Model và Entity
extension FaceEmbeddingModelX on FaceEmbeddingModel {
  // Model → Entity
  FaceEmbedding toEntity() => FaceEmbedding(
    id: id,
    userId: userId,
    vector1: vector1,
    vector2: vector2,
    vector3: vector3,
    vector4: vector4,
    vector5: vector5,
    registeredAt: registeredAt,
  );
}

extension FaceEmbeddingX on FaceEmbedding {
  // Entity → Model
  FaceEmbeddingModel toModel() => FaceEmbeddingModel(
    id: id,
    userId: userId,
    vector1: vector1,
    vector2: vector2,
    vector3: vector3,
    vector4: vector4,
    vector5: vector5,
    registeredAt: registeredAt,
  );
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_embedding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FaceEmbeddingModel _$FaceEmbeddingModelFromJson(Map<String, dynamic> json) =>
    _FaceEmbeddingModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      vector1: (json['vector1'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      vector2: (json['vector2'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      vector3: (json['vector3'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      vector4: (json['vector4'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      vector5: (json['vector5'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      registeredAt: DateTime.parse(json['registeredAt'] as String),
    );

Map<String, dynamic> _$FaceEmbeddingModelToJson(_FaceEmbeddingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'vector1': instance.vector1,
      'vector2': instance.vector2,
      'vector3': instance.vector3,
      'vector4': instance.vector4,
      'vector5': instance.vector5,
      'registeredAt': instance.registeredAt.toIso8601String(),
    };

class FaceEmbedding {
  final String id;
  final String userId;
  final List<double> vector1;
  final List<double> vector2;
  final List<double> vector3;
  final List<double> vector4;
  final List<double> vector5;
  final DateTime registeredAt;

  const FaceEmbedding({
    required this.id,
    required this.userId,
    required this.vector1,
    required this.vector2,
    required this.vector3,
    required this.vector4,
    required this.vector5,
    required this.registeredAt,
  });

  FaceEmbedding copyWith({
    String? id,
    String? userId,
    List<double>? vector1,
    List<double>? vector2,
    List<double>? vector3,
    List<double>? vector4,
    List<double>? vector5,
    DateTime? registeredAt,
  }) {
    return FaceEmbedding(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      vector1: vector1 ?? this.vector1,
      vector2: vector2 ?? this.vector2,
      vector3: vector3 ?? this.vector3,
      vector4: vector4 ?? this.vector4,
      vector5: vector5 ?? this.vector5,
      registeredAt: registeredAt ?? this.registeredAt,
    );
  }
}

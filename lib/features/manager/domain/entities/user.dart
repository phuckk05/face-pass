class User {
  final String id;
  final String name;
  final String? department;
  final String? avatarUrl;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.name,
    this.department,
    this.avatarUrl,
    required this.createdAt,
  });
}

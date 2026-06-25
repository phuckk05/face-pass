class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? phoneNumber;
  final String password;
  final String? department;
  final String? avatarUrl;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.password,
    this.phoneNumber,
    this.department,
    this.avatarUrl,
    required this.createdAt,
  });
}

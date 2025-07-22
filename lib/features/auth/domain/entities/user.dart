class User {
  final String id;
  final String email;
  final String name;
  final String? profileImageUrl;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? profileImageUrl,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
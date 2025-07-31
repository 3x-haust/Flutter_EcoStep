class Profile {
  final String id;
  final String email;
  final String name;
  final String? profileImageUrl;
  final int points;

  const Profile({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
    required this.points,
  });

  Profile copyWith({
    String? id,
    String? email,
    String? name,
    String? profileImageUrl,
    int? points,
  }) {
    return Profile(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      points: points ?? this.points,
    );
  }
}

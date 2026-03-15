class User {
  final String username;
  final String profileImageUrl;

  const User({
    required this.username,
    required this.profileImageUrl,
  });

  User copyWith({
    String? username,
    String? profileImageUrl,
  }) {
    return User(
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
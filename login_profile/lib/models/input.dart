class User {
  final String email;
  final String username;

  User({
    required this.email,
    required this.username,
  });

  User copyWith({String? email, String? username}) {
    return User(
      email: email ?? this.email,
      username: username ?? this.username,
    );
  }
}
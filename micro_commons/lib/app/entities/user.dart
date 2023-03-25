class User {
  final String accessToken;
  final String token;
  final String idToken;
  final String? refreshToken;
  final String? email;
  final String? name;
  final String? photoUrl;

  const User({
    required this.accessToken,
    required this.refreshToken,
    required this.idToken,
    required this.token,
    this.email,
    this.name,
    this.photoUrl,
  });
}

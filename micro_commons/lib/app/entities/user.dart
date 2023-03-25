import 'package:micro_commons/app/userRole.enum.dart';

class User {
  final String token;
  final String? email;
  final String? name;
  final String? photoUrl;
  final UserRole userRole;

  const User({
    required this.token,
    this.email,
    this.name,
    this.photoUrl,
    required this.userRole,
  });
}

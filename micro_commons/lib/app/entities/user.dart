import 'package:micro_commons/app/userRole.enum.dart';

class User {
  final String token;
  final String id;
  final String? email;
  final String? name;
  final String? photoUrl;
  final UserRole userRole;

  const User({
    required this.token,
    required this.id,
    this.email,
    this.name,
    this.photoUrl,
    required this.userRole,
  });
}

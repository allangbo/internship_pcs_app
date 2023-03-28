import 'dart:convert';
import 'package:micro_commons/app/entities/user.dart';
import 'package:micro_commons/app/userRole.enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _userKey = 'user';

  Future<void> saveUser(User user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userData = jsonEncode({
      'email': user.email,
      'name': user.name,
      'photoUrl': user.photoUrl,
      'token': user.token,
      'userRole': user.userRole.name
    });
    await sharedPreferences.setString(_userKey, userData);
  }

  Future<User?> getUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userData = sharedPreferences.getString(_userKey);
    if (userData != null) {
      final userMap = jsonDecode(userData) as Map<String, dynamic>;

      final userRoleName = userMap['userRole'] as String;
      final userRole = UserRole.values.firstWhere(
        (e) => e.name == userRoleName,
        orElse: () => UserRole.STUDENT,
      );

      return User(
        email: userMap['email'] ?? '',
        name: userMap['name'] ?? '',
        photoUrl: userMap['photoUrl'] ?? '',
        token: userMap['token'] ?? '',
        userRole: userRole,
      );
    }
    return null;
  }
}

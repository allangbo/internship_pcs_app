import 'dart:convert';
import 'package:micro_commons/app/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _userKey = 'user';

  Future<void> saveUser(User user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userData = jsonEncode({
      'accessToken': user.accessToken,
      'refreshToken': user.refreshToken,
      'idToken': user.idToken,
      'email': user.email,
      'name': user.name,
      'photoUrl': user.photoUrl,
      'token': user.token
    });
    await sharedPreferences.setString(_userKey, userData);
  }

  Future<User?> getUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userData = sharedPreferences.getString(_userKey);
    if (userData != null) {
      final userMap = jsonDecode(userData) as Map<String, dynamic>;
      return User(
          accessToken: userMap['accessToken'],
          refreshToken: userMap['refreshToken'],
          idToken: userMap['idToken'],
          email: userMap['email'],
          name: userMap['name'],
          photoUrl: userMap['photoUrl'],
          token: userMap['token']);
    }
    return null;
  }
}

import 'package:flutter/foundation.dart';
import 'package:micro_commons/app/entities/user.dart';
import 'package:micro_commons/app/user_store.dart';

class AuthState extends ChangeNotifier {
  final UserPreferences _userPreferences = UserPreferences();
  User? _user;

  User? get user => _user;

  bool get isAuthenticated => _user != null && _user!.accessToken.isNotEmpty;

  Future<void> init() async {
    _user = await _userPreferences.getUser();
    notifyListeners();
  }

  void setUser(User? user) {
    _user = user;
    if (user != null) {
      _userPreferences.saveUser(user);
    }
    notifyListeners();
  }
}

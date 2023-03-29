import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:micro_app_login/app/services/login.service.dart';
import 'package:micro_app_login/app/services/user.service.dart';
import 'package:micro_app_login/app/uri.dart';
import 'package:micro_commons/app/auth_state.dart';
import 'package:micro_commons/app/entities/user.dart';
import 'package:micro_commons/app/graphql_config.dart';
import 'package:micro_commons/app/userRole.enum.dart';

import 'package:oauth2/oauth2.dart' as oauth2;

class GoogleSignInService {
  final authorizationEndpoint =
      Uri.parse('https://accounts.google.com/o/oauth2/v2/auth');
  final tokenEndpoint = Uri.parse('https://oauth2.googleapis.com/token');
  final _loginService = LoginService();
  final _userService = UserService();
  AuthState authState;

  final String identifier;
  final String secret;
  final String baseUrl;
  final List<String> scopes;

  _SignInSession? _signInSession;

  Uri get redirectUrl => Uri.parse('$baseUrl/callback.html');

  GoogleSignInService(
      {required this.identifier,
      required this.secret,
      required this.baseUrl,
      required this.scopes,
      required this.authState}) {
    html.window.addEventListener('message', _eventListener);
  }

  void _eventListener(html.Event event) {
    _signInSession?.completeWithCode((event as html.MessageEvent).data);
  }

  Future<void> signIn({required UserRole userType}) async {
    final grant = oauth2.AuthorizationCodeGrant(
        identifier, authorizationEndpoint, tokenEndpoint,
        secret: secret, codeVerifier: '');

    var authorizationUrl =
        grant.getAuthorizationUrl(redirectUrl, scopes: scopes);

    final updatedQueryParameters =
        Map<String, String>.from(authorizationUrl.queryParameters)
          ..remove('code_challenge')
          ..remove('code_challenge_method');

    final updatedUri =
        authorizationUrl.replace(queryParameters: updatedQueryParameters);

    _signInSession = _SignInSession(updatedUri.toString());

    final code = await _signInSession!.codeCompleter.future;

    if (code != null) {
      final token = await _loginService.login(code: code, userType: userType);

      if (token != null) {
        GraphQLConfig(url: Uris.uriBase).setToken(token);

        final userData = await _userService.getUser();

        final user = User(
          token: token,
          userRole: userType,
          id: userData?['id'],
          name: userData?['name'],
          email: userData?['email'],
          photoUrl: userData?['photoUrl'],
        );

        authState.setUser(user);
      }
    }
  }
}

class _SignInSession {
  final codeCompleter = Completer<String?>();
  late final html.WindowBase _window;
  late final Timer _timer;

  bool get isClosed => codeCompleter.isCompleted;

  _SignInSession(String url) {
    const width = 550;
    const height = 600;
    final screenWidth = html.window.screen!.available.width;
    final screenHeight = html.window.screen!.available.height;
    final left = (screenWidth - width) ~/ 2;
    final top = (screenHeight - height) ~/ 2;
    _window = html.window.open(url, '_blank',
        'location=yes,width=$width,height=$height,left=$left,top=$top');
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_window.closed == true) {
        if (!isClosed) {
          codeCompleter.complete(null);
        }
        _timer.cancel();
      }
    });
  }

  void completeWithCode(String code) {
    if (!isClosed) {
      codeCompleter.complete(code);
    }
  }
}

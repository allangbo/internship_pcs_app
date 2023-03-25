import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_login/app/services/google_sign_in_web.service.dart';
import 'package:micro_commons/app/auth_state.dart';
import 'package:micro_commons/app/components/custom_form_button.dart';
import 'package:micro_commons/app/shared_routes.dart';
import 'package:provider/provider.dart';

GoogleSignInService _googleSignIn = GoogleSignInService(
  identifier:
      '249948252936-da6r3lln1thpehq374da1olkf2c4aphg.apps.googleusercontent.com',
  secret: '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',
  baseUrl: 'http://localhost:5000',
  scopes: [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ],
);

class LoginWebPage extends StatefulWidget {
  const LoginWebPage({Key? key}) : super(key: key);

  @override
  State<LoginWebPage> createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  bool _isLoading = false;
  final Logger _logger = Logger();

  Future<void> _handleSignIn(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final authState = Provider.of<AuthState>(context, listen: false);
    final navigator = Navigator.of(context);

    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        authState.setUser(user);
        navigator.pushReplacementNamed(SharedRoutes.home);
      }
    } catch (error) {
      _logger.e(error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomFormButton(
              onPressed: () => _handleSignIn(context),
              label: 'FAZER LOGIN COM O GOOGLE',
              isLoading: _isLoading,
              icon:
                  'packages/micro_app_login/lib/assets/images/google-logo.png',
            ),
          ],
        ),
      ),
    );
  }
}

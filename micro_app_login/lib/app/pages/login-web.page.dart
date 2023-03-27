import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_login/app/services/google_sign_in_web.service.dart';
import 'package:micro_commons/app/auth_state.dart';
import 'package:micro_commons/app/components/custom_form_button.dart';
import 'package:micro_commons/app/shared_routes.dart';
import 'package:micro_commons/app/userRole.enum.dart';
import 'package:provider/provider.dart';

class LoginWebPage extends StatefulWidget {
  const LoginWebPage({Key? key}) : super(key: key);

  @override
  State<LoginWebPage> createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  bool _isLoading = false;
  final _logger = Logger();
  UserRole _selectedRole = UserRole.aluno;

  Future<void> _handleSignIn(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final authState = Provider.of<AuthState>(context, listen: false);
    final navigator = Navigator.of(context);

    final googleSignIn = GoogleSignInService(
        identifier:
            '249948252936-da6r3lln1thpehq374da1olkf2c4aphg.apps.googleusercontent.com',
        secret: '',
        baseUrl: 'http://localhost:5000',
        scopes: [
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
        authState: authState);

    try {
      await googleSignIn.signIn(userType: _selectedRole);
      final user = authState.user;
      if (user != null) {
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

  Widget _userRoleDropdown() {
    return DropdownButton<UserRole>(
      value: _selectedRole,
      onChanged: (UserRole? newValue) {
        setState(() {
          _selectedRole = newValue!;
        });
      },
      items: UserRole.values.map<DropdownMenuItem<UserRole>>((UserRole value) {
        return DropdownMenuItem<UserRole>(
          value: value,
          child: Text(value.toString().split('.').last),
        );
      }).toList(),
    );
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
            _userRoleDropdown(),
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

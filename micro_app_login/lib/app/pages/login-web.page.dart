import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_login/app/services/google_sign_in_web.service.dart';
import 'package:micro_app_login/app/services/login.service.dart';
import 'package:micro_commons/app/auth_state.dart';
import 'package:micro_commons/app/components/custom_dropdown_field.dart';
import 'package:micro_commons/app/components/custom_form_button.dart';
import 'package:micro_commons/app/routes.dart';
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
  UserRole _selectedRole = UserRole.STUDENT;
  final _loginService = LoginService();
  final _formKey = GlobalKey<FormState>();

  Future<void> _handleSignIn(BuildContext context) async {
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    final authState = Provider.of<AuthState>(context, listen: false);
    final navigator = Navigator.of(context);

    final googleSignIn = GoogleSignInService(
        identifier:
            '249948252936-da6r3lln1thpehq374da1olkf2c4aphg.apps.googleusercontent.com',
        secret: '',
        baseUrl: _loginService.getBaseUrl(),
        scopes: [
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
        authState: authState);

    try {
      await googleSignIn.signIn(userType: _selectedRole);
      final user = authState.user;
      if (user != null) {
        navigator.pushReplacementNamed(Routes.home);
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Por favor, selecione o tipo do usuário:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30.0),
            Form(
              key: _formKey,
              child: Container(
                width: 327,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: CustomDropdownFormFieldStyles.borderColor),
                ),
                child: CustomDropdownFormField(
                  items: UserRole.values.map((e) => e.name).toList(),
                  itemCaptions: UserRole.values.map((e) => e.caption).toList(),
                  label: '',
                  onSaved: (value) {
                    _selectedRole = UserRole.values.firstWhere(
                        (e) => e.name == value,
                        orElse: () => UserRole.STUDENT);
                  },
                  value: _selectedRole.name,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
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

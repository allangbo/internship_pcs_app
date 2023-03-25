import 'package:flutter/material.dart';
import 'package:micro_commons/app/auth_state.dart';
import 'package:micro_commons/app/components/redirect_login.dart';
import 'package:provider/provider.dart';

class AuthRoute extends StatelessWidget {
  final Widget Function(BuildContext, AuthState) builder;

  const AuthRoute({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthState>(
      builder: (context, authState, child) {
        if (authState.isAuthenticated) {
          return builder(context, authState);
        } else {
          return const RedirectToLogin();
        }
      },
    );
  }
}

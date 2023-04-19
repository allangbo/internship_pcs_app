import 'package:flutter/material.dart';
import 'package:micro_commons/app/routes.dart';

class RedirectToLogin extends StatelessWidget {
  const RedirectToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigator.pushNamedAndRemoveUntil(
        Routes.login,
        (Route<dynamic> route) => false,
      );
    });

    return Container();
  }
}

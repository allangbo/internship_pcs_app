import 'package:flutter/material.dart';
import 'package:micro_commons/app/shared_routes.dart';

class RedirectToLogin extends StatelessWidget {
  const RedirectToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        SharedRoutes.login,
        (Route<dynamic> route) => false,
      );
    });

    return Container();
  }
}

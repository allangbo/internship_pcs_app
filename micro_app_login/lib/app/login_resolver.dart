import 'package:flutter/material.dart';
import 'package:micro_app_login/app/pages/login-web.page.dart';
import 'package:micro_commons/app/pages/error_page.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginResolver implements MicroApp {
  @override
  String get microAppName => 'micro_app_login';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
        Routes.login: (context, args) =>
            kIsWeb ? const LoginWebPage() : Container(),
        Routes.loginErrorPage: (context, args) => const ErrorPage(
              returnRoute: Routes.login,
              title: 'Login',
              message: 'Não foi possível fazer login.',
            )
      };
}

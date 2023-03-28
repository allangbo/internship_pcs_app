import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:micro_app_login/app/pages/login-web.page.dart';
import 'package:micro_app_login/app/pages/login.page.dart';
import 'package:micro_app_login/app/uri.dart';
import 'package:micro_commons/app/graphql_config.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginResolver implements MicroApp {
  _wrapWithGraphQLProvider(Widget widget) {
    ValueNotifier<GraphQLClient> client =
        GraphQLConfig(url: Uris.uriBase).graphInit();

    return GraphQLProvider(
      client: client,
      child: widget,
    );
  }

  @override
  String get microAppName => 'micro_app_login';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
        Routes.login: (context, args) => _wrapWithGraphQLProvider(
            kIsWeb ? const LoginWebPage() : const LoginPage()),
      };
}

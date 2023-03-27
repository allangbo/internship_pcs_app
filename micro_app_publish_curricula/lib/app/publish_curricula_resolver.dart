import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:micro_app_publish_curricula/app/graphql_config.dart';
import 'package:micro_app_publish_curricula/app/pages/publish_curricula_multi_form.page.dart';
import 'package:micro_app_publish_curricula/app/publish_curricula_routes.dart';
import 'package:micro_commons/app/auth_route.dart';
import 'package:micro_commons/app/pages/error_page.dart';
import 'package:micro_commons/app/pages/success_page.dart';
import 'package:micro_commons/app/shared_routes.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';

class PublishCurriculaResolver implements MicroApp {
  _wrapWithGraphQLProvider(Widget widget) {
    ValueNotifier<GraphQLClient> client = GraphQLConfig().graphInit();

    return GraphQLProvider(
      client: client,
      child: widget,
    );
  }

  @override
  String get microAppName => 'micro_app_publish_curricula';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
        /*PublishCurriculaRoutes.publishCurricula: (context, args) =>
            _wrapWithGraphQLProvider(const PublishCurriculaMultiFormPage()),*/
        PublishCurriculaRoutes.publishCurricula: (context, args) => AuthRoute(
              builder: (context, authState) =>
                  const PublishCurriculaMultiFormPage(),
            ),
        PublishCurriculaRoutes.errorPage: (context, args) => const ErrorPage(
              returnRoute: PublishCurriculaRoutes.publishCurricula,
              title: 'Publicar Currículo',
              message: 'Não foi possível publicar o currículo.',
            ),
        PublishCurriculaRoutes.successPage: (context, args) =>
            const SuccessPage(
              returnRoute: SharedRoutes.home,
              title: 'Publicar Currículo',
              message: 'Sucesso ao publicar o currículo.',
              labelActionButton: 'Retornar para o início',
            )
      };
}

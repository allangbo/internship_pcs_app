import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:micro_app_publish_vacancy/app/pages/publish_vacancy_multi_form.page.dart';
import 'package:micro_app_publish_vacancy/app/uri.dart';
import 'package:micro_commons/app/pages/error_page.dart';
import 'package:micro_commons/app/pages/success_page.dart';
import 'package:micro_commons/app/graphql_config.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';

class PublishVacancyResolver implements MicroApp {
  _wrapWithGraphQLProvider(Widget widget) {
    ValueNotifier<GraphQLClient> client =
        GraphQLConfig(url: Uris.uriBase).graphInit();

    return GraphQLProvider(
      client: client,
      child: widget,
    );
  }

  @override
  String get microAppName => 'micro_app_publish_vacancy';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
        Routes.publishVacancy: (context, args) =>
            _wrapWithGraphQLProvider(const PublishVacancyMultiFormPage()),
        Routes.publishVacancySuccessPage: (context, args) => const SuccessPage(
              title: 'Publicar Vaga',
              returnRoute: Routes.publishVacancy,
              message: 'Vaga adicionada com sucesso',
              labelActionButton: 'Adicionar outra vaga',
            ),
        Routes.publishVacancyErrorPage: (context, args) => const ErrorPage(
              returnRoute: Routes.publishVacancy,
              title: 'Publicar Vaga',
              message: 'Não foi possível publicar a vaga.',
            )
      };
}

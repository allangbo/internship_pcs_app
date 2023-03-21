import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:micro_app_list_vacancies/app/graphql_config.dart';
import 'package:micro_app_list_vacancies/app/list_vacancies_routes.dart';
import 'package:micro_app_list_vacancies/app/pages/list_vacancies.page.dart';
import 'package:micro_commons/app/pages/error_page.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';

class ListVacanciesResolver implements MicroApp {
  _wrapWithGraphQLProvider(Widget widget) {
    ValueNotifier<GraphQLClient> client = GraphQLConfig.graphInit();

    return GraphQLProvider(
      client: client,
      child: widget,
    );
  }

  @override
  String get microAppName => 'micro_app_list_vacancies';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
        ListVacanciesRoutes.listVacancies: (context, args) =>
            _wrapWithGraphQLProvider(const ListVacanciesPage()),
        ListVacanciesRoutes.errorPage: (context, args) => const ErrorPage(
              returnRoute: ListVacanciesRoutes.listVacancies,
              title: 'Vagas Publicadas',
              message: 'Não foi possível carregar as vagas.',
            )
      };
}

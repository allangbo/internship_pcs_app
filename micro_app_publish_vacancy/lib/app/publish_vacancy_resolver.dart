import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:micro_app_publish_vacancy/app/graphql_config.dart';
import 'package:micro_app_publish_vacancy/app/pages/error_page.dart';
import 'package:micro_app_publish_vacancy/app/pages/publish_vacancy_multi_form.page.dart';
import 'package:micro_app_publish_vacancy/app/pages/success_page.dart';
import 'package:micro_app_publish_vacancy/app/routes.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';

class PublishVacancyResolver implements MicroApp {
  _wrapWithGraphQLProvider(Widget widget) {
    ValueNotifier<GraphQLClient> client = GraphQLConfig.graphInit();

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
        Routes.successPage: (context, args) =>
            _wrapWithGraphQLProvider(const SuccessPage()),
        Routes.errorPage: (context, args) =>
            _wrapWithGraphQLProvider(const ErrorPage())
      };
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:micro_app_publish_vacancy/app/graphql_config.dart';
import 'package:micro_app_publish_vacancy/app/pages/publish_vacancy_multi_form.page.dart';
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
        '/publish_vacancy': (context, args) =>
            _wrapWithGraphQLProvider(const PublishVacancyMultiFormPage()),
      };
}

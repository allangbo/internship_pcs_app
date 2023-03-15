import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:micro_app_publish_vacancy/app/entities/internship_vacancy.dart';
import 'package:micro_app_publish_vacancy/app/graphql_config.dart';

//link apoio: https://murainoyakubu.medium.com/simplified-graphql-implementations-for-query-and-mutation-in-flutter-9bce1deda792

class VacancyService {
  String publishVacancyMutation = '''
            mutation createPosition(\$input: CreatePositionInput) {
	            createPosition(input: \$input) {
                id
              }
            }
        ''';

  Future<String> publishVacancy(InternshipVacancy vacancy) async {
    try {
      ///initializing GraphQLConfig
      GraphQLConfig graphQLConfiguration = GraphQLConfig();
      GraphQLClient client = GraphQLConfig.getGraphQLClient();
      var variables = {'input': vacancy.toJson()};
      QueryResult result = await client.mutate(
        MutationOptions(
            document: gql(publishVacancyMutation),
            variables: {'input': vacancy.toJson()}),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data);
        //  parse your response here and return
        // var data = User.fromJson(result.data["register"]);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  getPublishVacancyMutationWidget(
      Widget Function(
              MultiSourceResult<Object?> Function(Map<String, dynamic>,
                  {Object? optimisticResult}),
              QueryResult<Object?>?)
          builder,
      FutureOr<void> Function(Map<String, dynamic>?)? onCompleted) {
    return Mutation(
      options: MutationOptions(
        document: gql(publishVacancyMutation),
        onCompleted: onCompleted,
      ),
      builder: builder,
    );
  }
}

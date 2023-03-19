import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class VacancyService {
  String publishVacancyMutation = '''
            mutation createPosition(\$input: CreatePositionInput!) {
              createPosition(input: \$input) {
                id
              }
            }
        ''';

  getPublishVacancyMutationWidget(
      Widget Function(
              MultiSourceResult<Object?> Function(Map<String, dynamic>,
                  {Object? optimisticResult}),
              QueryResult<Object?>?)
          builder,
      FutureOr<void> Function(Map<String, dynamic>?)? onCompleted,
      {FutureOr<void> Function(OperationException?)? onError}) {
    return Mutation(
      options: MutationOptions(
          document: gql(publishVacancyMutation),
          onCompleted: onCompleted,
          onError: onError),
      builder: builder,
    );
  }
}

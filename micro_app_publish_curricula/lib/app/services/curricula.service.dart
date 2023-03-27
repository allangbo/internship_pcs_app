import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_publish_curricula/app/uri.dart';
import 'package:micro_commons/app/entities/curriculum.dart';
import 'package:micro_commons/app/graphql_config.dart';

class CurriculaService {
  final GraphQLClient _client =
      GraphQLConfig(url: Uris.uriBase).getGraphQLClient();
  final Logger _logger = Logger();

  String publishCurriculaMutation = '''
    mutation createCurriculum(\$input: CreateCurriculumInput!) {
      createCurriculum(input: \$input) {
        id
      }
    }
  ''';

  Future<String?> publishCurriculum(Curriculum curriculum) async {
    final options = MutationOptions(
      document: gql(publishCurriculaMutation),
      variables: {'input': curriculum.toJson()},
    );

    final result = await _client.mutate(options);

    if (result.hasException) {
      _logger.e('PublishCurriculum exception: ${result.exception}');
      return null;
    }

    return result.data?['createCurriculum']['id'];
  }

  getPublishCurriculaMutationWidget(
      Widget Function(
              MultiSourceResult<Object?> Function(Map<String, dynamic>,
                  {Object? optimisticResult}),
              QueryResult<Object?>?)
          builder,
      FutureOr<void> Function(Map<String, dynamic>?)? onCompleted,
      {FutureOr<void> Function(OperationException?)? onError}) {
    return Mutation(
      options: MutationOptions(
          document: gql(publishCurriculaMutation),
          onCompleted: onCompleted,
          onError: onError),
      builder: builder,
    );
  }
}

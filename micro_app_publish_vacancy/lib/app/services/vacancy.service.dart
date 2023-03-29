import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_publish_vacancy/app/uri.dart';
import 'package:micro_commons/app/entities/internship_vacancy.dart';
import 'package:micro_commons/app/graphql_config.dart';

class VacancyService {
  final GraphQLClient _client =
      GraphQLConfig(url: Uris.uriBase).getGraphQLClient();
  final Logger _logger = Logger();

  String publishVacancyMutation = '''
            mutation createPosition(\$input: CreatePositionInput!) {
              createPosition(input: \$input) {
                id
              }
            }
        ''';

  Future<String?> publishVacancy(InternshipVacancy internshipVacancy) async {
    final options = MutationOptions(
      document: gql(publishVacancyMutation),
      variables: {'input': internshipVacancy.toJson()},
    );

    final result = await _client.mutate(options);

    if (result.hasException) {
      _logger.e('PublishVacancy exception: ${result.exception}');
      return null;
    }

    return result.data?['createPosition']['id'];
  }
}

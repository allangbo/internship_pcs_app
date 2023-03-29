import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_list_vacancies/app/uri.dart';
import 'package:micro_commons/app/graphql_config.dart';

class ApplyVacancyService {
  final GraphQLClient _client =
      GraphQLConfig(url: Uris.uriBase).getGraphQLClient();
  final Logger _logger = Logger();

  String createApplicationMutation = '''
    mutation createApplication(\$input: CreateApplicationInput!) {
      createApplication(input: \$input) {
        id
        position {
          id
        }
        userId
      }
    }
    ''';

  Future<String?> applyToVacancy({required String vacancyId}) async {
    final variables = {
      'input': {
        'positionId': vacancyId,
      }
    };

    final options = MutationOptions(
      document: gql(createApplicationMutation),
      variables: variables,
    );

    final result = await _client.mutate(options);

    if (result.hasException) {
      _logger.e('Apply position exception: ${result.exception}');
      return null;
    }

    return result.data?['createApplication']['id'];
  }
}

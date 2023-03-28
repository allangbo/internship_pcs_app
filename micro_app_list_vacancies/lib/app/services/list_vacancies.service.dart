import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_list_vacancies/app/uri.dart';
import 'package:micro_commons/app/entities/internship_vacancy.dart';
import 'package:micro_commons/app/graphql_config.dart';

class ListVacanciesService {
  final GraphQLClient _client =
      GraphQLConfig(url: Uris.uriBase).getGraphQLClient();
  final Logger _logger = Logger();

  String listVacanciesQuery = '''
                    query GetAllPositionsQuery {
                      getAllPositions {
                        positionName
                        company
                        role
                        startsAt
                        endsAt
                      }
                    }
                    ''';

  Future<List<InternshipVacancy>?> getVacancies() async {
    final result =
        await _client.query(QueryOptions(document: gql(listVacanciesQuery)));

    if (result.hasException) {
      _logger.e('Login exception: ${result.exception}');
      return null;
    }

    final data = result.data?['getAllPositions'];

    final vacancies =
        List.from(data).map((e) => InternshipVacancy.fromJson(e)).toList();

    return vacancies;
  }
}

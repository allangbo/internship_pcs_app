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
                        id
                        userId
                        positionName
                        company
                        role
                        description
                        startsAt
                        endsAt
                        steps
                        benefits
                        area
                        location
                        scholarship
                      }
                    }
                    ''';

  Future<List<InternshipVacancy>?> getVacancies() async {
    var vacancies = <InternshipVacancy>[];

    final result =
        await _client.query(QueryOptions(document: gql(listVacanciesQuery)));

    if (result.hasException) {
      _logger.e('Get all positions exception: ${result.exception}');
      return vacancies;
    }

    final data = result.data?['getAllPositions'];

    try {
      vacancies =
          List.from(data).map((e) => InternshipVacancy.fromJson(e)).toList();
    } catch (e) {
      _logger.e('Get all positions exception: $e');
    }

    return vacancies;
  }
}

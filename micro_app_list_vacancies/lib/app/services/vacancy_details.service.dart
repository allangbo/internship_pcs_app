import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_list_vacancies/app/uri.dart';
import 'package:micro_commons/app/entities/internship_vacancy.dart';
import 'package:micro_commons/app/graphql_config.dart';

class VacancyDetailService {
  final GraphQLClient _client =
      GraphQLConfig(url: Uris.uriBase).getGraphQLClient();
  final Logger _logger = Logger();

  String getPositionQuery = '''
                    query GetPosition(\$input: GetPositionByIdInput!){
                      getPositionById(input: \$input) {
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

  Future<InternshipVacancy?> getPositionById(String id) async {
    final result = await _client
        .query(QueryOptions(document: gql(getPositionQuery), variables: {
      'input': {'id': id}
    }));

    if (result.hasException) {
      _logger.e('GetPosition exception: ${result.exception}');
      return null;
    }

    final data = result.data?['getPositionById'];

    if (data != null) {
      return InternshipVacancy.fromJson(data);
    } else {
      return null;
    }
  }
}

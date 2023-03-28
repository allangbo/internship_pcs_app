import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_list_curricula/app/uri.dart';
import 'package:micro_commons/app/entities/curriculum.dart';
import 'package:micro_commons/app/graphql_config.dart';

class ListCurriculaService {
  final GraphQLClient _client =
      GraphQLConfig(url: Uris.uriBase).getGraphQLClient();
  final Logger _logger = Logger();

  String listCurriculaQuery = '''
                    query GetAllCurricula {
                      getAllCurricula {
                        id
                        name
                        lastName
                        degreeCourse
                        graduationYear
                        pastExperiences {
                          company
                          role
                          description
                          startedAt
                          endedAt
                        }
                        certificates {
                          name
                          description
                          completedAt
                          expiresAt
                        }
                      }
                    }
                    ''';

  Future<List<Curriculum>?> getCurriculas() async {
    final result =
        await _client.query(QueryOptions(document: gql(listCurriculaQuery)));

    if (result.hasException) {
      _logger.e('Login exception: ${result.exception}');
      return null;
    }

    final data = result.data?['getAllCurricula'];

    final curricula =
        List.from(data).map((e) => Curriculum.fromJson(e)).toList();

    return curricula;
  }
}

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_curricula_details/app/uri.dart';
import 'package:micro_commons/app/entities/curriculum.dart';
import 'package:micro_commons/app/graphql_config.dart';

class CurriculaDetailService {
  final GraphQLClient _client =
      GraphQLConfig(url: Uris.uriBase).getGraphQLClient();
  final Logger _logger = Logger();

  String getCurriculumForCompanyQuery = '''
                    query GetCurriculumForCompanyQuery(\$input: GetCurriculumForCompanyInput!) {
                      getCurriculumForCompany(input: \$input) {
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

  String getCurriculumForStudentQuery = '''
                    query GetCurriculumForStudentQuery {
                      getCurriculum {
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

  Future<Curriculum?> getCurriculumForCompanyByStudentId(
      String studentId) async {
    final result = await _client.query(
        QueryOptions(document: gql(getCurriculumForCompanyQuery), variables: {
      'input': {'studentId': studentId}
    }));

    if (result.hasException) {
      _logger.e('getCurriculumForCompany exception: ${result.exception}');
      return null;
    }

    final data = result.data?['getCurriculumForCompany'];

    if (data != null) {
      return Curriculum.fromJson(data);
    } else {
      return null;
    }
  }

  Future<Curriculum?> getCurriculumForStudent() async {
    final result = await _client.query(QueryOptions(
      document: gql(getCurriculumForStudentQuery),
    ));

    if (result.hasException) {
      _logger.e('getCurriculum exception: ${result.exception}');
      return null;
    }

    final data = result.data?['getCurriculum'];

    if (data != null) {
      return Curriculum.fromJson(data);
    } else {
      return null;
    }
  }
}

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_list_applications/app/uri.dart';
import 'package:micro_commons/app/entities/application.dart';
import 'package:micro_commons/app/graphql_config.dart';

class ListApplicationsService {
  final GraphQLClient _client =
      GraphQLConfig(url: Uris.uriBase).getGraphQLClient();
  final Logger _logger = Logger();

  String listApplicationsByCompanyQuery = '''
                    query getAllApplicationsByCompanyQuery {
                      getAllApplicationsByCompany {
                        id
                        position {
                          id
                          userId
                          positionName
                          company
                          role
                          startsAt
                          endsAt
                        }
                        userId
                      }
                    }
                    ''';

  String listApplicationsByStudentQuery = '''
                    query getAllApplicationsByStudentQuery {
                      getAllApplicationsByStudent {
                        id
                        position {
                          id
                          userId
                          positionName
                          company
                          role
                          startsAt
                          endsAt
                        }
                        userId
                      }
                    }
                    ''';

  Future<List<Application>> getApplicationsByCompany() async {
    final result = await _client
        .query(QueryOptions(document: gql(listApplicationsByCompanyQuery)));

    if (result.hasException) {
      _logger
          .e('Get all applications by company exception: ${result.exception}');
      return [];
    }

    final data = result.data?['getAllApplicationsByCompany'];

    final applications = data != null
        ? List.from(data).map((e) => Application.fromJson(e)).toList()
        : <Application>[];

    return applications;
  }

  Future<List<Application>> getApplicationsByStudent() async {
    final result = await _client
        .query(QueryOptions(document: gql(listApplicationsByStudentQuery)));

    if (result.hasException) {
      _logger
          .e('Get all applications by student exception: ${result.exception}');
      return [];
    }

    final data = result.data?['getAllApplicationsByStudent'];

    final applications = data != null
        ? List.from(data).map((e) => Application.fromJson(e)).toList()
        : <Application>[];

    return applications;
  }
}

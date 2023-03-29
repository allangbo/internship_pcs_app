import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_list_applications/app/uri.dart';
import 'package:micro_commons/app/entities/application.dart';
import 'package:micro_commons/app/graphql_config.dart';

class ListApplicationsService {
  final GraphQLClient _client =
      GraphQLConfig(url: Uris.uriBase).getGraphQLClient();
  final Logger _logger = Logger();

  String listApplicationsQuery = '''
                    query GetAllApplicationsQuery {
                      getAllApplications {
                        id
                        position {
                          id
                          positionName
                          company
                        }
                        userId
                      }
                    }
                    ''';

  Future<List<Application>?> getApplications() async {
    final result =
        await _client.query(QueryOptions(document: gql(listApplicationsQuery)));

    if (result.hasException) {
      _logger.e('Get all applications exception: ${result.exception}');
      return null;
    }

    final data = result.data?['getAllApplications'];

    final applications =
        List.from(data).map((e) => Application.fromJson(e)).toList();

    return applications;
  }
}

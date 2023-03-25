import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_login/app/graphql_config.dart';

class UserService {
  final Logger _logger = Logger();

  String getUserQuery = '''
    query getUser {
      getUser {
        id
        name
        email
      }
    }
  ''';

  Future<Map<String, dynamic>?> getUser() async {
    final client = GraphQLConfig().getGraphQLClient();

    final options = QueryOptions(
      document: gql(getUserQuery),
    );

    final result = await client.query(options);

    if (result.hasException) {
      _logger.e('GetUser exception: ${result.exception}');
      return null;
    }

    return result.data?['getUser'];
  }
}

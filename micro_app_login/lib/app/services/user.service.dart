import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_login/app/uri.dart';
import 'package:micro_commons/app/graphql_config.dart';

class UserService {
  final Logger _logger = Logger();

  String getUserQuery = '''
    query getUser {
      getUser {
        id
        name
        email
        profilePictureUrl
      }
    }
  ''';

  Future<Map<String, dynamic>?> getUser() async {
    final client = GraphQLConfig(url: Uris.uriBase).getGraphQLClient();

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

import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_login/app/graphql_config.dart';

class LoginService {
  final GraphQLClient _client = GraphQLConfig.getGraphQLClient();
  final Logger _logger = Logger();

  String loginMutation = '''
    mutation Login(\$input: LoginInput!) {
        login(input: \$input) {
          token
        }
      }
    ''';

  Future<String?> login({required String code}) async {
    final variables = {
      'input': {
        'code': code,
      }
    };

    final options = MutationOptions(
      document: gql(loginMutation),
      variables: variables,
    );

    final result = await _client.mutate(options);

    if (result.hasException) {
      _logger.e('Login exception: ${result.exception}');
      return null;
    }

    return result.data?['login']['token'];
  }
}

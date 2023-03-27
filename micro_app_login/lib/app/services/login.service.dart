import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_login/app/uri.dart';
import 'package:micro_commons/app/graphql_config.dart';
import 'package:micro_commons/app/userRole.enum.dart';

class LoginService {
  final GraphQLClient _client =
      GraphQLConfig(url: Uris.uriBase).getGraphQLClient();
  final Logger _logger = Logger();

  String loginMutation = '''
    mutation Login(\$input: LoginInput!) {
        login(input: \$input) {
          token
        }
      }
    ''';

  static const userRoleNames = {
    UserRole.aluno: 'STUDENT',
    UserRole.professor: 'TEACHER',
    UserRole.empresa: 'COMPANY',
  };

  Future<String?> login(
      {required String code, required UserRole userType}) async {
    final variables = {
      'input': {'code': code, 'userType': userRoleNames[userType]}
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

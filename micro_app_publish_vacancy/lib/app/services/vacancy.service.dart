import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:micro_app_publish_vacancy/app/entities/internship_vacancy.dart';
import 'package:micro_app_publish_vacancy/app/graphql_config.dart';

//link apoio: https://murainoyakubu.medium.com/simplified-graphql-implementations-for-query-and-mutation-in-flutter-9bce1deda792

class VacancyService {
  static String publishVacancyMutation() {
    return '''
            mutation createPosition(\$input: CreatePositionInput) {
	            createPosition(input: \$input) {
                id
              }
            }
        ''';
  }

  Future<String> publishVacancy(InternshipVacancy vacancy) async {
    try {
      ///initializing GraphQLConfig
      GraphQLConfig graphQLConfiguration = GraphQLConfig();
      GraphQLClient client = graphQLConfiguration.clientToQuery();
      var variables = {'input': vacancy.toJson()};
      QueryResult result = await client.mutate(
        MutationOptions(
            document: gql(publishVacancyMutation()),
            variables: {'input': vacancy.toJson()}),
      );
      if (result.hasException) {
        print(result.exception?.graphqlErrors[0].message);
      } else if (result.data != null) {
        print(result.data);
        //  parse your response here and return
        // var data = User.fromJson(result.data["register"]);
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }
}

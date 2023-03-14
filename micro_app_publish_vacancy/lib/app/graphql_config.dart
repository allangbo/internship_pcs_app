import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static String token = "";
  static HttpLink httpLink = HttpLink(
    'https://positions-internship-service-4ue6fqcuea-uc.a.run.app/graphql',
  );

  static getGraphQLClient() {
    return GraphQLClient(
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
      link: httpLink,
    );
  }

  static ValueNotifier<GraphQLClient> graphInit() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      getGraphQLClient(),
    );

    return client;
  }
}

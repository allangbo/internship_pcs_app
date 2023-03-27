import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static final GraphQLConfig _instance = GraphQLConfig._internal();
  factory GraphQLConfig() => _instance;
  GraphQLConfig._internal();

  String? _token;

  void setToken(String? token) {
    _token = token;
  }

  HttpLink httpLink = HttpLink(
    'https://curricula-internship-service-4ue6fqcuea-uc.a.run.app/graphql',
  );

  GraphQLClient getGraphQLClient() {
    Link link = httpLink;

    if (_token != null && _token!.isNotEmpty) {
      AuthLink authLink = AuthLink(
        getToken: () => _token,
      );
      link = authLink.concat(httpLink);
    }

    return GraphQLClient(
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
      link: link,
    );
  }

  ValueNotifier<GraphQLClient> graphInit() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      getGraphQLClient(),
    );

    return client;
  }
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static final GraphQLConfig _instance = GraphQLConfig._internal();
  factory GraphQLConfig({required String url}) {
    _instance._setUrl(url);
    return _instance;
  }
  GraphQLConfig._internal();

  String? _token;
  String _url = '';

  void setToken(String? token) {
    _token = token;
  }

  void _setUrl(String? url) {
    if (url != null && url.isNotEmpty) {
      _url = url;
    }
  }

  HttpLink get httpLink => HttpLink(_url);

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

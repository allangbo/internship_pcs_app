import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ListVacanciesService {
  String listVacanciesQuery = '''
                    query GetAllPositionsQuery {
                      getAllPositions {
                        positionName
                      }
                    }
                    ''';

  getListVacanciesQueryWidget(
      Widget Function(QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore})
          builder) {
    return Query(
      options: QueryOptions(
        document: gql(listVacanciesQuery),
        pollInterval: const Duration(seconds: 10),
      ),
      builder: builder,
    );
  }
}

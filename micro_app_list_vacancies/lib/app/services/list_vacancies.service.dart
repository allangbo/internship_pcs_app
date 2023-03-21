import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ListVacanciesService {
  String listVacanciesQuery = '''
                    query GetAllPositionsQuery {
                      getAllPositions {
                        positionName
                        company
                        role
                        startsAt
                        endsAt
                      }
                    }
                    ''';

  getListVacanciesQueryWidget(
      Widget Function(QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore})
          builder) {
    return Query(
      options: QueryOptions(document: gql(listVacanciesQuery)),
      builder: builder,
    );
  }
}

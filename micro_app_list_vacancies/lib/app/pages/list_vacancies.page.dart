import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:micro_app_list_vacancies/app/entities/internship_vacancy.dart';
import 'package:micro_app_list_vacancies/app/services/list_vacancies.service.dart';

class ListVacanciesPage extends StatefulWidget {
  const ListVacanciesPage({Key? key}) : super(key: key);

  @override
  State<ListVacanciesPage> createState() => _ListVacanciesPageState();
}

class _ListVacanciesPageState extends State<ListVacanciesPage> {
  final _listVacanciesService = ListVacanciesService();

  Widget _buildVaga(String nome, String empresa, String area) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.03),
            offset: Offset(0, 4),
            blurRadius: 16,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            nome,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(12, 12, 38, 1),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            empresa,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Color.fromRGBO(99, 99, 128, 1),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            area,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Color.fromRGBO(99, 99, 128, 1),
            ),
          ),
        ],
      ),
    );
  }

  _getListViewVacancies() {
    builder(QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
      if (result.hasException) {
        return Text(result.exception.toString());
      }

      if (result.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      final vacancies =
          result.data!['getAllPositions'] as List<InternshipVacancy>;

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        itemCount: vacancies.length,
        itemBuilder: (BuildContext context, int index) {
          final vacancy = vacancies[index];

          return _buildVaga(vacancy.name, "Empresa", vacancy.area ?? "");
        },
      );
    }

    return _listVacanciesService.getListVacanciesQueryWidget(builder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(250, 250, 253, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(27, 60, 0, 0),
              child: Text(
                'Listagem de Vagas',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  color: Color.fromRGBO(53, 104, 153, 1),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: _getListViewVacancies(),
            ),
          ],
        ),
      ),
    );
  }
}

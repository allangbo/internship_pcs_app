import 'package:flutter/material.dart';
import 'package:micro_app_list_vacancies/app/components/vacancy_item.dart';
import 'package:micro_app_list_vacancies/app/services/list_vacancies.service.dart';
import 'package:micro_commons/app/entities/internship_vacancy.dart';

class ListVacanciesPage extends StatefulWidget {
  const ListVacanciesPage({Key? key}) : super(key: key);

  @override
  State<ListVacanciesPage> createState() => _ListVacanciesPageState();
}

class _ListVacanciesPageState extends State<ListVacanciesPage> {
  final _listVacanciesService = ListVacanciesService();
  List<InternshipVacancy> _vacancies = [];
  List<InternshipVacancy> _filteredVacancies = [];
  List<InternshipVacancy> _originalVacancies = [];
  bool _isLoading = true;
  String _searchQuery = '';

  Widget _buildVacancyItem(InternshipVacancy vacancy) {
    return VacancyItem(
        name: vacancy.name,
        company: 'Nubank',
        area: vacancy.area ?? '',
        imageUrl: '',
        salary: 2000,
        location: vacancy.city ?? '');
  }

  void _searchVacancies(String query) {
    setState(() {
      _searchQuery = query;
    });
    if (query.isEmpty) {
      setState(() {
        _filteredVacancies = [];
        _vacancies = _originalVacancies;
      });
    } else {
      final filteredVacancies = _originalVacancies.where((vacancy) {
        final name = vacancy.name.toLowerCase();
        const company = '';
        final area = vacancy.area?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) ||
            company.contains(query.toLowerCase()) ||
            area.contains(query.toLowerCase());
      }).toList();
      setState(() {
        _filteredVacancies = filteredVacancies;
        _vacancies = filteredVacancies;
      });
    }
  }

  Widget _buildSearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar vagas...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              filled: true,
              fillColor: ListVacanciesStyle.searchFieldColor,
            ),
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
              _searchVacancies(query);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 27, bottom: 10),
          child: Text(
            '${_vacancies.length} vagas encontradas',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListViewVacancies() {
    final vacanciesToDisplay =
        _filteredVacancies.isNotEmpty ? _filteredVacancies : _vacancies;
    return ListView.builder(
      padding: ListVacanciesStyle.listViewPadding,
      itemCount: vacanciesToDisplay.length,
      itemBuilder: (BuildContext context, int index) {
        final vacancy = vacanciesToDisplay[index];
        return _buildVacancyItem(vacancy);
      },
    );
  }

  void _getVacancies() async {
    final vacancies = await _listVacanciesService.getVacancies();

    if (vacancies != null) {
      setState(() {
        _originalVacancies = vacancies;
        _vacancies = vacancies;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getVacancies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(
                  context); // fecha a tela atual e retorna à tela anterior
            },
          ),
        ],
        title: const Text(
          "Vagas Publicadas",
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: ListVacanciesStyle.containerColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSearchField(),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _vacancies.isEmpty
                      ? const Center(child: Text('Nenhuma vaga encontrada'))
                      : _filteredVacancies.isEmpty && _searchQuery.isNotEmpty
                          ? const Center(child: Text('Nenhuma vaga encontrada'))
                          : _buildListViewVacancies(),
            ),
          ],
        ),
      ),
    );
  }
}

class ListVacanciesStyle {
  static const Color whiteColor = Colors.white;
  static const Color containerColor = Color.fromRGBO(250, 250, 253, 1);
  static const Color primaryColor = Color.fromRGBO(53, 104, 153, 1);
  static const Color secondaryColor = Color(0xFF636380);
  static const Color searchFieldColor = Color.fromRGBO(232, 232, 232, 1);
  static const List<BoxShadow> boxShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.03),
      offset: Offset(0, 4),
      blurRadius: 16,
    ),
  ];
  static const EdgeInsetsGeometry listViewPadding =
      EdgeInsets.symmetric(horizontal: 27);
  static const EdgeInsetsGeometry titlePadding =
      EdgeInsets.fromLTRB(27, 30, 0, 0);
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontFamily: 'Poppins',
    color: primaryColor,
  );
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Poppins',
    color: secondaryColor,
  );
}

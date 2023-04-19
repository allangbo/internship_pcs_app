import 'package:flutter/material.dart';
import 'package:micro_app_list_vacancies/app/services/list_vacancies.service.dart';
import 'package:micro_commons/app/components/custom_list.dart';
import 'package:micro_commons/app/entities/internship_vacancy.dart';
import 'package:micro_commons/app/routes.dart';

class ListVacanciesPage extends StatefulWidget {
  const ListVacanciesPage({Key? key}) : super(key: key);

  @override
  State<ListVacanciesPage> createState() => _ListVacanciesPageState();
}

class _ListVacanciesPageState extends State<ListVacanciesPage> {
  final _listVacanciesService = ListVacanciesService();
  List<InternshipVacancy> _vacancies = [];
  bool _isLoading = true;

  void _getVacancies() async {
    final vacancies = await _listVacanciesService.getVacancies();

    if (vacancies != null) {
      setState(() {
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
              Navigator.pop(context);
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
          children: [
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomList(
                      items: _vacancies
                          .map((e) => Item(
                              title: e.name,
                              text1: e.company,
                              text2: e.scholarship != null
                                  ? 'R\$ ${e.scholarship?.toStringAsFixed(2)}/mês'
                                  : '',
                              imageUrl: '',
                              onAction: () => {
                                    Navigator.of(context).pushNamed(
                                        Routes.vacancyDetailsPage,
                                        arguments: {'id': e.id})
                                  }))
                          .toList(),
                    ),
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

import 'package:flutter/material.dart';
import 'package:micro_app_list_vacancies/app/services/vacancy_details.service.dart';
import 'package:micro_commons/app/components/custom_form_button.dart';
import 'package:micro_commons/app/entities/internship_vacancy.dart';
import 'package:micro_commons/app/routes.dart';

class VacancyDetailsPage extends StatefulWidget {
  final String vacancyId;

  const VacancyDetailsPage({Key? key, required this.vacancyId})
      : super(key: key);

  @override
  State<VacancyDetailsPage> createState() => _VacancyDetailsPageState();
}

class _VacancyDetailsPageState extends State<VacancyDetailsPage> {
  bool _isLoading = true;
  InternshipVacancy? _vacancy;
  final _vacancyDetailService = VacancyDetailService();

  void _getVacancies() async {
    final vacancy =
        await _vacancyDetailService.getPositionById(widget.vacancyId);

    if (vacancy != null) {
      setState(() {
        _vacancy = vacancy;
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              "Detalhes da Vaga",
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.home);
                },
              ),
            ]),
        body: Column(
          children: [
            _isLoading
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(_vacancy?.imageUrl ?? ''),
                          radius: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _vacancy?.name ?? 'Name',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _vacancy?.company ?? 'Company',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Text('Bolsa'),
                                const SizedBox(height: 4),
                                Text(_vacancy?.scholarship != null
                                    ? 'R\$ ${_vacancy?.scholarship?.toStringAsFixed(2)}/mês'
                                    : ''),
                              ],
                            ),
                            const SizedBox(width: 32),
                            Column(
                              children: [
                                const Text('Localização'),
                                const SizedBox(height: 4),
                                Text(_vacancy?.location ?? 'Location'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            TabBar(
              labelColor: const Color.fromARGB(255, 0, 0, 0),
              indicatorColor: Theme.of(context).primaryColor,
              tabs: const [
                Tab(text: 'Descrição'),
                Tab(text: 'Requisitos'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_vacancy?.description ?? 'Description'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_vacancy?.requirements ?? 'Requirements'),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomFormButton(
                label: 'Aplicar Agora',
                onPressed: () {},
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VacancyDetailsStyle {
  static const Color buttonColor = Color(0xff356899);
  static const double buttonFontSize = 16;
}

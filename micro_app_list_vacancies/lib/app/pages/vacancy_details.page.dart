import 'package:flutter/material.dart';
import 'package:micro_app_list_vacancies/app/services/apply_vacancy.service.dart';
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
  bool _isLoadingApply = false;
  InternshipVacancy? _vacancy;
  final _vacancyDetailService = VacancyDetailService();
  final _applyVacancyService = ApplyVacancyService();

  Future<void> _showApplyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aplicar para a vaga'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Tem certeza de que deseja aplicar para esta vaga?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop();
                _applyToVacancy();
              },
            ),
          ],
        );
      },
    );
  }

  _applyToVacancy() async {
    final navigator = Navigator.of(context);
    setState(() {
      _isLoadingApply = true;
    });

    final applicationId = _vacancy?.id != null
        ? await _applyVacancyService.applyToVacancy(
            vacancyId: _vacancy?.id ?? '')
        : null;

    if (applicationId != null) {
      navigator.pushReplacementNamed(Routes.applyVacancySuccessPage);
    } else {
      navigator.pushReplacementNamed(Routes.applyVacancyErrorPage);
    }
  }

  void _getVacancy() async {
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
    _getVacancy();
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
        bottomNavigationBar: !_isLoading
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomFormButton(
                      label: 'Aplicar Agora',
                      onPressed: _showApplyDialog,
                      isLoading: _isLoadingApply,
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}

class VacancyDetailsStyle {
  static const Color buttonColor = Color(0xff356899);
  static const double buttonFontSize = 16;
}

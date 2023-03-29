import 'package:flutter/material.dart';
import 'package:micro_app_list_applications/app/services/list_applications.service.dart';
import 'package:micro_commons/app/components/custom_list.dart';
import 'package:micro_commons/app/entities/application.dart';

class ListApplicationsPage extends StatefulWidget {
  const ListApplicationsPage({Key? key}) : super(key: key);

  @override
  State<ListApplicationsPage> createState() => _ListApplicationsPageState();
}

class _ListApplicationsPageState extends State<ListApplicationsPage> {
  final _listApplicationsService = ListApplicationsService();
  List<Application> _applications = [];
  bool _isLoading = true;

  void _getApplications() async {
    final applications = await _listApplicationsService.getApplications();

    if (applications != null) {
      setState(() {
        _applications = applications;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getApplications();
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
          "Candidaturas",
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: ListApplicationsStyle.containerColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomList(
                      items: _applications
                          .map((e) => Item(
                              title: 'Nome do usuário',
                              text1: e.vacancy.name,
                              text2: e.vacancy.company,
                              imageUrl: '',
                              onAction: () => {}))
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListApplicationsStyle {
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

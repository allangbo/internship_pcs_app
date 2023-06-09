import 'package:flutter/material.dart';
import 'package:micro_app_list_applications/app/services/list_applications.service.dart';
import 'package:micro_commons/app/components/custom_list.dart';
import 'package:micro_commons/app/entities/application.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_commons/app/userRole.enum.dart';

class ListApplicationsPage extends StatefulWidget {
  final UserRole userType;
  const ListApplicationsPage({Key? key, required this.userType})
      : super(key: key);

  @override
  State<ListApplicationsPage> createState() => _ListApplicationsPageState();
}

class _ListApplicationsPageState extends State<ListApplicationsPage> {
  final _listApplicationsService = ListApplicationsService();
  Future<List<Application>>? _futureData;

  Future<List<Application>> _getApplicationsByCompany() async {
    final applications =
        await _listApplicationsService.getApplicationsByCompany();

    return applications;
  }

  Future<List<Application>> _getApplicationsByStudent() async {
    final applications =
        await _listApplicationsService.getApplicationsByStudent();

    return applications;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      switch (widget.userType) {
        case UserRole.COMPANY:
          _futureData = _getApplicationsByCompany();
          break;
        case UserRole.STUDENT:
          _futureData = _getApplicationsByStudent();
          break;
        default:
      }
    });
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
              child: FutureBuilder<List<Application>>(
                future: _futureData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.listApplicationsErrorPage);
                    return Container();
                  } else {
                    final applications = snapshot.data ?? [];
                    return CustomList(
                      items: applications
                          .map((e) => Item(
                              title: e.vacancy.name,
                              text1: 'Candidatura ${e.id}',
                              text2: e.vacancy.company,
                              imageUrl: '',
                              onAction: widget.userType == UserRole.COMPANY
                                  ? () => {
                                        Navigator.of(context).pushNamed(
                                            Routes.curriculaDetailsPage,
                                            arguments: {
                                              'studentId': e.userId,
                                              'userType': widget.userType
                                            })
                                      }
                                  : () => {}))
                          .toList(),
                    );
                  }
                },
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

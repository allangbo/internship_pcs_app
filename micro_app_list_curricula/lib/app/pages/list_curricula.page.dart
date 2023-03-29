import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:micro_app_list_curricula/app/services/list_curricula_service.dart';
import 'package:micro_commons/app/components/custom_list.dart';
import 'package:micro_commons/app/entities/curriculum.dart';

class ListCurriculaPage extends StatefulWidget {
  const ListCurriculaPage({Key? key}) : super(key: key);

  @override
  State<ListCurriculaPage> createState() => _ListCurriculaPageState();
}

class _ListCurriculaPageState extends State<ListCurriculaPage> {
  final _listCurriculasService = ListCurriculaService();
  List<Curriculum> _curriculas = [];
  bool _isLoading = true;

  void _getCurriculas() async {
    final curriculas = await _listCurriculasService.getCurriculas();

    if (curriculas != null) {
      setState(() {
        _curriculas = curriculas;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurriculas();
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
          "Currículos",
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: ListCurriculasStyle.containerColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomList(
                      items: _curriculas
                          .map((e) => Item(
                              title: '${e.name} ${e.lastName}',
                              text1: e.degreeCourse,
                              text2:
                                  DateFormat('yyyy').format(e.graduationYear),
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

class ListCurriculasStyle {
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

import 'package:flutter/material.dart';
import 'package:micro_app_list_curricula/app/components/curricula_item.dart';
import 'package:micro_app_list_curricula/app/services/list_curricula_service.dart';
import 'package:micro_commons/app/entities/curriculum.dart';

class ListCurriculaPage extends StatefulWidget {
  const ListCurriculaPage({Key? key}) : super(key: key);

  @override
  State<ListCurriculaPage> createState() => _ListCurriculaPageState();
}

class _ListCurriculaPageState extends State<ListCurriculaPage> {
  final _listCurriculasService = ListCurriculaService();
  List<Curriculum> _curriculas = [];
  List<Curriculum> _filteredCurriculas = [];
  List<Curriculum> _originalCurriculas = [];
  bool _isLoading = true;
  String _searchQuery = '';

  Widget _buildCurriculaItem(Curriculum curricula) {
    return CurriculaItem(
      curricula: curricula,
    );
  }

  void _searchCurriculas(String query) {
    setState(() {
      _searchQuery = query;
    });
    if (query.isEmpty) {
      setState(() {
        _filteredCurriculas = [];
        _curriculas = _originalCurriculas;
      });
    } else {
      final filteredCurriculas = _originalCurriculas.where((curricula) {
        final name = curricula.name.toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
      setState(() {
        _filteredCurriculas = filteredCurriculas;
        _curriculas = filteredCurriculas;
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
              hintText: 'Buscar currículos...',
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
              fillColor: ListCurriculasStyle.searchFieldColor,
            ),
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
              _searchCurriculas(query);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 27, bottom: 10),
          child: Text(
            '${_curriculas.length} currículos encontrados',
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

  Widget _buildListViewCurriculas() {
    final vacanciesToDisplay =
        _filteredCurriculas.isNotEmpty ? _filteredCurriculas : _curriculas;
    return ListView.builder(
      padding: ListCurriculasStyle.listViewPadding,
      itemCount: vacanciesToDisplay.length,
      itemBuilder: (BuildContext context, int index) {
        final curriculum = vacanciesToDisplay[index];
        return _buildCurriculaItem(curriculum);
      },
    );
  }

  void _getCurriculas() async {
    final curriculas = await _listCurriculasService.getCurriculas();

    if (curriculas != null) {
      setState(() {
        _originalCurriculas = curriculas;
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
          children: <Widget>[
            _buildSearchField(),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _curriculas.isEmpty
                      ? const Center(child: Text('Nenhum currículo encontrado'))
                      : _filteredCurriculas.isEmpty && _searchQuery.isNotEmpty
                          ? const Center(
                              child: Text('Nenhum currículo encontrado'))
                          : _buildListViewCurriculas(),
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

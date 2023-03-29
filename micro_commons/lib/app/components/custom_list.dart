import 'package:flutter/material.dart';
import 'package:micro_commons/app/components/custom_list_item.dart';

class Item {
  String title;
  String text1;
  String text2;
  String? text3;
  String? text4;
  String? imageUrl;
  VoidCallback onAction;

  Item({
    required this.title,
    required this.text1,
    required this.text2,
    required this.onAction,
    this.text3,
    this.text4,
    this.imageUrl,
  });
}

class CustomList extends StatefulWidget {
  final List<Item> items;

  const CustomList({Key? key, required this.items}) : super(key: key);

  @override
  State<CustomList> createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
  List<Item> _filteredItems = [];
  List<Item> _originalItems = [];
  String _searchQuery = '';
  List<Item> items = [];

  Widget _buildItem(Item item) {
    return CustomListItem(item: item);
  }

  void _searchItems(String query) {
    setState(() {
      _searchQuery = query;
    });
    if (query.isEmpty) {
      setState(() {
        _filteredItems = [];
        items = _originalItems;
      });
    } else {
      final filteredItems = _originalItems.where((item) {
        final title = item.title.toLowerCase();
        final text1 = item.text1.toLowerCase();
        final text2 = item.text2.toLowerCase();
        return title.contains(query.toLowerCase()) ||
            text1.contains(query.toLowerCase()) ||
            text2.contains(query.toLowerCase());
      }).toList();
      setState(() {
        _filteredItems = filteredItems;
        items = filteredItems;
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
              hintText: 'Buscar itens...',
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
              fillColor: CustomListStyle.searchFieldColor,
            ),
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
              _searchItems(query);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 27, bottom: 10),
          child: Text(
            '${widget.items.length} itens encontrados',
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

  Widget _buildListViewItems() {
    final itemsToDisplay =
        _filteredItems.isNotEmpty ? _filteredItems : widget.items;
    return ListView.builder(
      padding: CustomListStyle.listViewPadding,
      itemCount: itemsToDisplay.length,
      itemBuilder: (BuildContext context, int index) {
        final item = itemsToDisplay[index];
        return _buildItem(item);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    items = widget.items;
    _originalItems = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSearchField(),
        const SizedBox(height: 20),
        Expanded(
          child: widget.items.isEmpty
              ? const Center(child: Text('Nenhum item encontrado'))
              : _filteredItems.isEmpty && _searchQuery.isNotEmpty
                  ? const Center(child: Text('Nenhum item encontrado'))
                  : _buildListViewItems(),
        ),
      ],
    );
  }
}

class CustomListStyle {
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

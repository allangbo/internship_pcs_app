import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final VoidCallback onDeletePressed;
  final VoidCallback? onReorderPressed;
  final int index;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.index,
    required this.onDeletePressed,
    this.onReorderPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      index: index,
      child: ListTile(
        key: key,
        title: Text(
          title,
          style: CustomListTileStyle.titleTextStyle,
        ),
        leading: CircleAvatar(
          backgroundColor: CustomListTileStyle.circleColor,
          radius: CustomListTileStyle.circleRadius,
          child: Icon(
            Icons.drag_handle,
            color: Colors.white,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: CustomListTileStyle.iconColor,
          ),
          onPressed: onDeletePressed,
        ),
        onTap: onReorderPressed,
      ),
    );
  }
}

class CustomListTileStyle {
  static const TextStyle titleTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: -0.16,
    color: Color(0xff0c0c26),
  );

  static const Color circleColor = Color(0xff356899);
  static const double circleRadius = 14;
  static const Color iconColor = Color(0xff666666);
}

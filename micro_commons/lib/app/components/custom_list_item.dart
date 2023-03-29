import 'package:flutter/material.dart';
import 'package:micro_commons/app/components/custom_list.dart';

class CustomListItemStyle {
  static const Color whiteColor = Color(0xffffffff);
  static const Color shadowColor = Color(0x07000000);
  static const List<BoxShadow> boxShadow = [
    BoxShadow(
      color: shadowColor,
      offset: Offset(0, 4),
      blurRadius: 8,
    ),
  ];

  static const TextStyle titleStyle = TextStyle(
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    color: Color(0xff0c0c26),
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 13,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
    color: Color(0xff0c0c26),
  );
}

class CustomListItem extends StatefulWidget {
  final Item item;

  const CustomListItem({Key? key, required this.item}) : super(key: key);

  @override
  State<CustomListItem> createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.item.onAction,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: CustomListItemStyle.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: CustomListItemStyle.boxShadow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: DecorationImage(
                  image: AssetImage(
                    widget.item.imageUrl != null &&
                            widget.item.imageUrl!.isNotEmpty
                        ? widget.item.imageUrl!
                        : 'packages/micro_commons/lib/assets/images/default_image.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    widget.item.title,
                    style: CustomListItemStyle.titleStyle,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item.text1,
                    style: CustomListItemStyle.subtitleStyle,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.item.text2,
                        style: CustomListItemStyle.subtitleStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.item.text3 ?? '',
                        style: CustomListItemStyle.subtitleStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

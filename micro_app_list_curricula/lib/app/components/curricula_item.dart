import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:micro_commons/app/entities/curriculum.dart';

class CurriculaItemStyle {
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

class CurriculaItem extends StatelessWidget {
  final Curriculum curricula;

  const CurriculaItem({Key? key, required this.curricula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String fullName = '${curricula.name} ${curricula.lastName}';
    final String formattedGraduationYear =
        DateFormat('yyyy').format(curricula.graduationYear);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: CurriculaItemStyle.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: CurriculaItemStyle.boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              style: CurriculaItemStyle.titleStyle,
            ),
            const SizedBox(height: 4),
            Text(
              curricula.degreeCourse,
              style: CurriculaItemStyle.subtitleStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'Graduação: $formattedGraduationYear',
              style: CurriculaItemStyle.subtitleStyle,
            ),
          ],
        ),
      ),
    );
  }
}

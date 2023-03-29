import 'package:flutter/material.dart';

class VacancyItemStyle {
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

class VacancyItem extends StatelessWidget {
  final String name;
  final String company;
  final String area;
  final String imageUrl;
  final double salary;
  final String location;
  final VoidCallback? onAction;

  const VacancyItem({
    Key? key,
    required this.name,
    required this.company,
    required this.area,
    required this.imageUrl,
    required this.salary,
    required this.location,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAction,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: VacancyItemStyle.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: VacancyItemStyle.boxShadow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage(
                      'packages/micro_app_list_vacancies/lib/assets/images/logo_nubank.png'),
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
                    name,
                    style: VacancyItemStyle.titleStyle,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    company,
                    style: VacancyItemStyle.subtitleStyle,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'R\$ ${salary.toStringAsFixed(2)}/mês',
                        style: VacancyItemStyle.subtitleStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        location,
                        style: VacancyItemStyle.subtitleStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Divider(height: 1, thickness: 1, color: Colors.grey[300]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

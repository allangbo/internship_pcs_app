import 'package:flutter/material.dart';
import 'package:micro_app_curricula_details/app/services/curricula_details.service.dart';
import 'package:micro_commons/app/entities/curriculum.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_commons/app/userRole.enum.dart';

class CurriculumDetailsPageStyle {
  static const Color primaryColor = Color(0xFF4C8BF5);
  static const Color secondaryColor = Color(0xFF687C9A);
  static const TextStyle headerTextStyle =
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primaryColor);
  static const TextStyle subHeaderTextStyle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: secondaryColor);
  static const TextStyle infoTextStyle =
      TextStyle(fontSize: 18, color: secondaryColor);
  static const TextStyle smallInfoTextStyle =
      TextStyle(fontSize: 16, color: secondaryColor);
  static const TextStyle smallTextStyle =
      TextStyle(fontSize: 14, color: secondaryColor);
  static const double verticalSpacing = 10.0;
  static const double sectionSpacing = 20.0;
}

class CurriculumDetailsPage extends StatefulWidget {
  final UserRole userType;
  final String? studentId;

  const CurriculumDetailsPage({
    Key? key,
    this.studentId,
    required this.userType,
  }) : super(key: key);

  @override
  State<CurriculumDetailsPage> createState() => _CurriculumDetailsPageState();
}

class _CurriculumDetailsPageState extends State<CurriculumDetailsPage> {
  final _curriculaDetailService = CurriculaDetailService();
  Future<Curriculum?>? _futureData;

  Future<Curriculum?> _getCurriculumForCompany(String studentId) async {
    final curriculum = await _curriculaDetailService
        .getCurriculumForCompanyByStudentId(studentId);

    return curriculum;
  }

  Future<Curriculum?> _getCurriculumForStudent() async {
    final curriculum = await _curriculaDetailService.getCurriculumForStudent();

    return curriculum;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      switch (widget.userType) {
        case UserRole.COMPANY:
          if (widget.studentId != null) {
            _futureData = _getCurriculumForCompany(widget.studentId ?? '');
          }
          break;
        case UserRole.STUDENT:
          if (widget.studentId != null) {
            _futureData = _getCurriculumForStudent();
          }
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do Currículo"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: FutureBuilder<Curriculum?>(
              future: _futureData,
              builder: (context, snapshot) {
                final curriculum = snapshot.data;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || curriculum == null) {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.curriculaDetailsErrorPage);
                  return Container();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${curriculum.name} ${curriculum.lastName}',
                        style: CurriculumDetailsPageStyle.headerTextStyle,
                      ),
                      const SizedBox(
                          height: CurriculumDetailsPageStyle.verticalSpacing),
                      Text(
                        'Curso: ${curriculum.degreeCourse}',
                        style: CurriculumDetailsPageStyle.infoTextStyle,
                      ),
                      const SizedBox(
                          height: CurriculumDetailsPageStyle.verticalSpacing),
                      Text(
                        'Ano de formatura: ${curriculum.graduationYear.year}',
                        style: CurriculumDetailsPageStyle.infoTextStyle,
                      ),
                      const SizedBox(
                          height: CurriculumDetailsPageStyle.sectionSpacing),
                      const Text(
                        'Experiências passadas',
                        style: CurriculumDetailsPageStyle.subHeaderTextStyle,
                      ),
                      const SizedBox(
                          height: CurriculumDetailsPageStyle.verticalSpacing),
                      for (Experience experience in curriculum.pastExperiences)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              experience.company,
                              style: CurriculumDetailsPageStyle.infoTextStyle,
                            ),
                            const SizedBox(
                                height:
                                    CurriculumDetailsPageStyle.verticalSpacing),
                            Text(
                              '${experience.role} (${experience.startedAt.year} - ${experience.endedAt.year})',
                              style:
                                  CurriculumDetailsPageStyle.smallInfoTextStyle,
                            ),
                            const SizedBox(
                                height:
                                    CurriculumDetailsPageStyle.verticalSpacing),
                            Text(
                              experience.description,
                              style: CurriculumDetailsPageStyle.smallTextStyle,
                            ),
                            const SizedBox(
                                height:
                                    CurriculumDetailsPageStyle.verticalSpacing),
                          ],
                        ),
                      const SizedBox(
                          height: CurriculumDetailsPageStyle.sectionSpacing),
                      const Text(
                        'Certificados',
                        style: CurriculumDetailsPageStyle.subHeaderTextStyle,
                      ),
                      const SizedBox(
                          height: CurriculumDetailsPageStyle.verticalSpacing),
                      for (Activity activity in curriculum.certificates)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity.name,
                              style: CurriculumDetailsPageStyle.infoTextStyle,
                            ),
                            const SizedBox(
                                height:
                                    CurriculumDetailsPageStyle.verticalSpacing),
                            Text(
                              '${activity.description} (${activity.completedAt.year})',
                              style:
                                  CurriculumDetailsPageStyle.smallInfoTextStyle,
                            ),
                            const SizedBox(
                                height:
                                    CurriculumDetailsPageStyle.verticalSpacing),
                            Text(
                              'Validade: ${activity.expiresAt.year}',
                              style: CurriculumDetailsPageStyle.smallTextStyle,
                            ),
                            const SizedBox(
                                height:
                                    CurriculumDetailsPageStyle.verticalSpacing),
                          ],
                        ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}

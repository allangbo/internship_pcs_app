import 'package:flutter/material.dart';
import 'package:micro_app_curricula_details/app/services/curricula_details.service.dart';
import 'package:micro_commons/app/entities/curriculum.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_commons/app/userRole.enum.dart';

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
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Curso: ${curriculum.degreeCourse}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ano de formatura: ${curriculum.graduationYear.year}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Experiências passadas',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    for (Experience experience in curriculum.pastExperiences)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            experience.company,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${experience.role} (${experience.startedAt.year} - ${experience.endedAt.year})',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            experience.description,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    const SizedBox(height: 16),
                    const Text(
                      'Certificados',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    for (Activity activity in curriculum.certificates)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.name,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${activity.description} (${activity.completedAt.year})',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Validade: ${activity.expiresAt.year}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                  ],
                );
              }
            }),
      ),
    );
  }
}

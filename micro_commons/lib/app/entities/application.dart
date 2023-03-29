import 'package:micro_commons/app/entities/internship_vacancy.dart';

class Application {
  String id;
  InternshipVacancy vacancy;
  String userId;

  Application({required this.id, required this.vacancy, required this.userId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['position'] = vacancy.toJson();
    data['userId'] = userId;
    return data;
  }

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'] ?? '',
      vacancy: InternshipVacancy.fromJson(json['position']),
      userId: json['userId'] ?? '',
    );
  }
}

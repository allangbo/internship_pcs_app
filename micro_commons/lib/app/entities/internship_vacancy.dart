import 'package:intl/intl.dart';

class InternshipVacancy {
  String name;
  DateTime openingDate;
  DateTime closingDate;
  String description;
  String requirements;
  String modality;
  double? scholarship;
  String? city;
  String? area;
  String? benefits;
  List<String>? steps;

  InternshipVacancy(
      {required this.name,
      required this.openingDate,
      required this.closingDate,
      required this.description,
      required this.requirements,
      required this.modality,
      this.scholarship,
      this.city,
      this.area,
      this.benefits,
      this.steps});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['positionName'] = name;
    data['company'] = name;
    data['role'] = area;
    data['startsAt'] = DateFormat('yyyy-MM-dd').format(openingDate);
    data['endsAt'] = DateFormat('yyyy-MM-dd').format(closingDate);
    //data['endsAt'] = closingDate.toIso8601String();
    //data['description'] = description;
    //data['requirements'] = requirements;
    //data['modality'] = modality;
    //data['scholarship'] = scholarship;
    //data['city'] = city;

    //data['benefits'] = benefits;
    //data['steps'] = steps;
    return data;
  }

  factory InternshipVacancy.fromJson(Map<String, dynamic> json) {
    return InternshipVacancy(
      name: json['positionName'] ?? '',
      openingDate: DateTime.parse(
          json['startsAt'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now())),
      closingDate: DateTime.parse(
          json['endsAt'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now())),
      description: json['description'] ?? '',
      requirements: json['requirements'] ?? '',
      modality: json['modality'] ?? '',
      scholarship: json['scholarship'] ?? 0,
      city: json['city'] ?? '',
      area: json['role'] ?? '',
      benefits: json['benefits'] ?? '',
      steps: List<String>.from(json['steps'] ?? []),
    );
  }
}

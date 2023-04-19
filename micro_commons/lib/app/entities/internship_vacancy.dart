import 'package:intl/intl.dart';

class InternshipVacancy {
  String id;
  String name;
  DateTime openingDate;
  DateTime closingDate;
  String description;
  String requirements;
  String modality;
  String company;
  String userId;
  double? scholarship;
  String? location;
  String? area;
  String? benefits;
  List<String>? steps;

  InternshipVacancy({
    required this.id,
    required this.name,
    required this.openingDate,
    required this.closingDate,
    required this.description,
    required this.requirements,
    required this.modality,
    required this.company,
    required this.userId,
    this.scholarship,
    this.location,
    this.area,
    this.benefits,
    this.steps,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['positionName'] = name;
    data['userId'] = userId;
    data['company'] = company;
    data['area'] = area;
    data['startsAt'] = DateFormat('yyyy-MM-dd').format(openingDate);
    data['endsAt'] = DateFormat('yyyy-MM-dd').format(closingDate);
    data['description'] = description;
    data['steps'] = steps;
    data['benefits'] = benefits;
    data['compensation'] = '0';
    data['role'] = modality;
    data['location'] = location;
    data['scholarship'] = scholarship.toString();

    //data['requirements'] = requirements;
    return data;
  }

  factory InternshipVacancy.fromJson(Map<String, dynamic> json) {
    return InternshipVacancy(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      name: json['positionName'] ?? '',
      openingDate: DateTime.parse(
          json['startsAt'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now())),
      closingDate: DateTime.parse(
          json['endsAt'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now())),
      description: json['description'] ?? '',
      requirements: json['requirements'] ?? '',
      modality: json['role'] ?? '',
      scholarship: double.tryParse(json['scholarship'] ?? '') ?? 0,
      location: json['location'] ?? '',
      area: json['area'] ?? '',
      benefits: json['benefits'] ?? '',
      company: json['company'] ?? '',
      steps: List<String>.from(json['steps'] ?? []),
    );
  }
}

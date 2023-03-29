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
  String? imageUrl;
  double? scholarship;
  String? location;
  String? area;
  String? benefits;
  List<String>? steps;

  InternshipVacancy(
      {required this.id,
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
      this.imageUrl});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['positionName'] = name;
    data['userId'] = userId;
    data['company'] = company;
    data['role'] = area;
    data['startsAt'] = DateFormat('yyyy-MM-dd').format(openingDate);
    data['endsAt'] = DateFormat('yyyy-MM-dd').format(closingDate);

    //data['endsAt'] = closingDate.toIso8601String();
    //data['description'] = description;
    //data['requirements'] = requirements;
    //data['modality'] = modality;
    //data['scholarship'] = scholarship;
    //data['location'] = location;
    //data['benefits'] = benefits;
    //data['steps'] = steps;
    //data['imageUrl'] = imageUrl
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
      modality: json['modality'] ?? '',
      scholarship: json['scholarship'] ?? 0,
      location: json['city'] ?? '',
      area: json['role'] ?? '',
      benefits: json['benefits'] ?? '',
      company: json['company'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      steps: List<String>.from(json['steps'] ?? []),
    );
  }
}

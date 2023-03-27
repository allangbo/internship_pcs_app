import 'package:intl/intl.dart';

class Curriculum {
  String name;
  String lastName;
  String degreeCourse;
  DateTime graduationYear;
  List<Experience> pastExperiences;
  List<Activity> certificates;

  Curriculum({
    required this.name,
    required this.lastName,
    required this.degreeCourse,
    required this.graduationYear,
    required this.pastExperiences,
    required this.certificates,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['lastName'] = lastName;
    data['degreeCourse'] = degreeCourse;
    data['graduationYear'] = DateFormat('yyyy-MM-dd').format(graduationYear);
    data['pastExperiences'] = pastExperiences.map((e) => e.toJson()).toList();
    data['certificates'] = certificates.map((a) => a.toJson()).toList();
    return data;
  }

  factory Curriculum.fromJson(Map<String, dynamic> json) {
    return Curriculum(
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      degreeCourse: json['degreeCourse'] ?? '',
      graduationYear: DateTime.parse(json['graduationYear'] ??
          DateFormat('yyyy-MM-dd').format(DateTime.now())),
      pastExperiences: (json['pastExperiences'] as List)
          .map((e) => Experience.fromJson(e))
          .toList(),
      certificates: (json['certificates'] as List)
          .map((a) => Activity.fromJson(a))
          .toList(),
    );
  }
}

class Experience {
  String company;
  String role;
  String description;
  DateTime startedAt;
  DateTime endedAt;

  Experience({
    required this.company,
    required this.role,
    required this.description,
    required this.startedAt,
    required this.endedAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company'] = company;
    data['role'] = role;
    data['description'] = description;
    data['startedAt'] = DateFormat('yyyy-MM-dd').format(startedAt);
    data['endedAt'] = DateFormat('yyyy-MM-dd').format(endedAt);
    return data;
  }

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      company: json['company'] ?? '',
      role: json['role'] ?? '',
      description: json['description'] ?? '',
      startedAt: DateTime.parse(
          json['startedAt'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now())),
      endedAt: DateTime.parse(
          json['endedAt'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now())),
    );
  }
}

class Activity {
  String name;
  String description;
  DateTime completedAt;
  DateTime expiresAt;

  Activity({
    required this.name,
    required this.description,
    required this.completedAt,
    required this.expiresAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['completedAt'] = DateFormat('yyyy-MM-dd').format(completedAt);
    data['expiresAt'] = DateFormat('yyyy-MM-dd').format(expiresAt);
    return data;
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      completedAt: DateTime.parse(json['completedAt'] ??
          DateFormat('yyyy-MM-dd').format(DateTime.now())),
      expiresAt: DateTime.parse(
          json['expiresAt'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now())),
    );
  }
}

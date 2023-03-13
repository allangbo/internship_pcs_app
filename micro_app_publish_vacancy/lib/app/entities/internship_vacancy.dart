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
}

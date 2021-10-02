class SchoolModel {
  SchoolModel({
    this.id,
    this.name,
    this.city,
    this.state,
    this.competitor,
  });

  final int id;
  final String name;
  final String city;
  final String state;
  final dynamic competitor;

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
        id: json["id"],
        name: json["Name"],
        city: json["City"],
        state: json["State"],
        competitor: json["competitor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "City": city,
        "State": state,
        "competitor": competitor,
      };
}

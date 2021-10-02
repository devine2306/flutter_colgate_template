class EventGradeModel {
  EventGradeModel({
    this.id,
    this.name,
    this.image,
  });

  final int id;
  final String name;
  final dynamic image;

  factory EventGradeModel.fromJson(Map<String, dynamic> json) =>
      EventGradeModel(
        id: json["id"],
        name: json["Grade"],
        image: json["Image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Grade": name,
        "Image": image,
      };
}

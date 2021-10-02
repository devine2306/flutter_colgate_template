class EventStageModel {
  EventStageModel({
    this.id,
    this.name,
  });

  final int id;
  final String name;

  factory EventStageModel.fromJson(Map<String, dynamic> json) =>
      EventStageModel(
        id: json["id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
      };
}

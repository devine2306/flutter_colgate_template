class ScheduleModel {
  ScheduleModel({
    this.id,
    this.location,
    this.eventType,
  });

  final int id;
  final String location;
  final String eventType;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["id"],
        location: json["Location"],
        eventType: json["EventType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Location": location,
        "EventType": eventType,
      };
}

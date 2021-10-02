class FaqModel {
  FaqModel({
    this.id,
    this.question,
    this.anwser,
  });

  final int id;
  final String question;
  final String anwser;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        id: json["id"],
        question: json["Question"],
        anwser: json["Anwser"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Question": question,
        "Anwser": anwser,
      };
}

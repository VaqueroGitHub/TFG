import 'dart:convert';

Answer answerFromJson(String str) => Answer.fromJson(json.decode(str));

String answerToJson(Answer data) => json.encode(data.toJson());

class Answer {
  Answer({
    required this.answer,
    required this.idPost,
    required this.idUser,
  });

  String answer;
  String idPost;
  String idUser;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        answer: json["answer"],
        idPost: json["idPost"],
        idUser: json["idUser"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "idPost": idPost,
        "idUser": idUser,
      };
}

import 'dart:convert';

import 'package:flutter_application_tfg/models/user.dart';

Answer answerFromJson(String str) => Answer.fromJson(json.decode(str));

String answerToJson(Answer data) => json.encode(data.toJson());

class Answer {
  Answer({
    required this.answer,
    required this.idPost,
    required this.idUser,
    this.id,
    this.user,
  });

  String answer;
  String idPost;
  String idUser;
  User? user;
  String? id;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        answer: json["answer"],
        idPost: json["idPost"],
        idUser: json["idUser"],
        id: json["id"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "idPost": idPost,
        "idUser": idUser,
      };
}

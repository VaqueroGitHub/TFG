import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:intl/intl.dart';

Answer answerFromJson(String str) => Answer.fromJson(json.decode(str));

String answerToJson(Answer data) => json.encode(data.toJson());

class Answer {
  Answer({
    required this.answer,
    required this.idPost,
    required this.idUser,
    required this.datetime,
    this.id,
    this.user,
  });

  String answer;
  String idPost;
  String idUser;
  Timestamp datetime;
  User? user;
  String? id;

  String get dateTimeToString {
    return DateFormat('dd/MM/yyyy, HH:mm').format(
        DateTime.fromMicrosecondsSinceEpoch(datetime.microsecondsSinceEpoch));
  }

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        answer: json["answer"],
        idPost: json["idPost"],
        idUser: json["idUser"],
        id: json["id"],
        user: json["user"],
        datetime: json['datetime'],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "idPost": idPost,
        "idUser": idUser,
        'datetime': datetime,
      };
}

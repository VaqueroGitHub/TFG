import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:intl/intl.dart';

GroupMessage answerFromJson(String str) =>
    GroupMessage.fromJson(json.decode(str));

String answerToJson(GroupMessage data) => json.encode(data.toJson());

class GroupMessage {
  GroupMessage({
    required this.message,
    required this.idGroup,
    required this.idUser,
    required this.datetime,
    this.id,
    this.user,
  });

  String message;
  String idGroup;
  String idUser;
  Timestamp datetime;
  User? user;
  String? id;

  String get dateTimeToString {
    return DateFormat('dd/MM/yyyy, HH:mm').format(
        DateTime.fromMicrosecondsSinceEpoch(datetime.microsecondsSinceEpoch));
  }

  factory GroupMessage.fromJson(Map<String, dynamic> json) => GroupMessage(
        message: json["message"],
        idGroup: json["idGroup"],
        idUser: json["idUser"],
        id: json["id"],
        user: json["user"],
        datetime: json['datetime'],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "idGroup": idGroup,
        "idUser": idUser,
        'datetime': datetime,
      };
}

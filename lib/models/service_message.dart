import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:intl/intl.dart';

ServiceMessage answerFromJson(String str) =>
    ServiceMessage.fromJson(json.decode(str));

String answerToJson(ServiceMessage data) => json.encode(data.toJson());

class ServiceMessage {
  ServiceMessage({
    required this.message,
    required this.idService,
    required this.idUser,
    required this.datetime,
    this.id,
    this.user,
  });

  String message;
  String idService;
  String idUser;
  Timestamp datetime;
  User? user;
  String? id;

  String get dateTimeToString {
    return DateFormat('dd/MM/yyyy, HH:mm').format(
        DateTime.fromMicrosecondsSinceEpoch(datetime.microsecondsSinceEpoch));
  }

  factory ServiceMessage.fromJson(Map<String, dynamic> json) => ServiceMessage(
        message: json["message"],
        idService: json["idGroup"],
        idUser: json["idUser"],
        id: json["id"],
        user: json["user"],
        datetime: json['datetime'],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "idGroup": idService,
        "idUser": idUser,
        'datetime': datetime,
      };
}

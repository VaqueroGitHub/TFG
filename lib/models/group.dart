import 'package:flutter_application_tfg/models/user.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

class Group {
  Group(
      {required this.asignatura,
      required this.year,
      required this.description,
      required this.nMembersRequired,
      required this.idMembers,
      required this.idUser,
      this.id,
      this.user});

  String asignatura;
  int year;
  String description;
  int nMembersRequired;
  List<String> idMembers;
  String idUser;
  String? id;
  User? user;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        asignatura: json["asignatura"],
        year: json["year"],
        description: json["description"],
        nMembersRequired: json["nMembersRequired"],
        idMembers: List<String>.from(json["idMembers"].map((x) => x)),
        idUser: json["idUser"],
        id: json["id"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "asignatura": asignatura,
        "year": year,
        "description": description,
        "nMembersRequired": nMembersRequired,
        "idMembers": List<dynamic>.from(idMembers.map((x) => x)),
        "idUser": idUser,
      };
}

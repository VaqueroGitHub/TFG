import 'dart:convert';

import 'package:flutter_application_tfg/models/user.dart';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service(
      {required this.code,
      required this.conference,
      required this.description,
      required this.idOwnerUser,
      required this.idCustomerUser,
      required this.nCoins,
      this.userCustomer,
      this.userOwner,
      this.id});

  String code;
  String conference;
  String description;
  String idOwnerUser;
  String idCustomerUser;
  int nCoins;
  User? userOwner;
  User? userCustomer;
  String? id;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        code: json["code"],
        conference: json["conference"],
        description: json["description"],
        idOwnerUser: json["idOwnerUser"],
        idCustomerUser: json["idCustomerUser"],
        nCoins: json["nCoins"],
        userCustomer: json["userCustomer"],
        userOwner: json["userOwner"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "conference": conference,
        "description": description,
        "idOwnerUser": idOwnerUser,
        "idCustomerUser": idCustomerUser,
        "nCoins": nCoins,
      };
}

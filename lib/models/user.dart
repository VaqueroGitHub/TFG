import 'dart:core';

class User {
  User({
    required this.nick,
    required this.fullName,
    required this.email,
    required this.password,
    required this.isAdmin,
  });

  String nick;
  String fullName;
  String email;
  String password;
  bool isAdmin;

  factory User.fromJson(Map<String, dynamic> json) => User(
        nick: json["nick"],
        fullName: json["name"],
        email: json["email"],
        password: json["password"],
        isAdmin: json["isAdmin"],
      );

  Map<String, dynamic> toJson() => {
        "nick": nick,
        "name": fullName,
        "email": email,
        "password": password,
        "isAdmin": isAdmin,
      };
}

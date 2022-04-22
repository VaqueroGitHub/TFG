import 'dart:core';

class User {
  User({
    required this.nick,
    required this.fullName,
    required this.email,
    required this.password,
    required this.isAdmin,
    required this.bio,
    this.url,
    this.id,
  });

  String nick;
  String fullName;
  String email;
  String password;
  bool isAdmin;
  String bio;
  String? url;
  String? id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        nick: json["nick"],
        fullName: json["name"],
        email: json["email"],
        password: json["password"],
        isAdmin: json["isAdmin"],
        bio: json["bio"],
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "nick": nick,
        "name": fullName,
        "email": email,
        "password": password,
        "isAdmin": isAdmin,
        "bio": bio,
      };
}

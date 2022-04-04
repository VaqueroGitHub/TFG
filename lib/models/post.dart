import 'dart:convert';

import 'package:flutter_application_tfg/models/forum_section.dart';
import 'package:flutter_application_tfg/models/user.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.title,
    required this.body,
    required this.idUser,
    required this.idForumSection,
    this.answered,
    this.id,
    this.user,
    this.forumSection,
  });

  String title;
  String body;
  String idUser;
  String idForumSection;
  bool? answered;
  String? id;
  User? user;
  ForumSection? forumSection;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json["title"],
        body: json["body"],
        idUser: json["idUser"],
        idForumSection: json["idForumSection"],
        answered: json['answered'],
        user: json['user'],
        id: json["id"],
        forumSection: json["forumSection"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "idUser": idUser,
        "idForumSection": idForumSection,
      };
}

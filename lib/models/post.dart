import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.title,
    required this.body,
    required this.idUser,
    required this.idForumSection,
    this.id,
  });

  String title;
  String body;
  String idUser;
  String idForumSection;
  String? id;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json["title"],
        body: json["body"],
        idUser: json["idUser"],
        idForumSection: json["idForumSection"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "idUser": idUser,
        "idForumSection": idForumSection,
      };
}

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.title,
    required this.body,
    required this.idUser,
    required this.idForumSection,
  });

  String title;
  String body;
  String idUser;
  String idForumSection;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json["title"],
        body: json["body"],
        idUser: json["idUser"],
        idForumSection: json["idForumSection"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "idUser": idUser,
        "idForumSection": idForumSection,
      };
}

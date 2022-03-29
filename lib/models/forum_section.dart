import 'dart:convert';

ForumSection forumSectionFromJson(String str) =>
    ForumSection.fromJson(json.decode(str));

String forumSectionToJson(ForumSection data) => json.encode(data.toJson());

class ForumSection {
  ForumSection({
    this.id,
    required this.title,
  });

  String? id;
  String title;

  factory ForumSection.fromJson(Map<String, dynamic> json) => ForumSection(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

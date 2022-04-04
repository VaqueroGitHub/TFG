import 'package:flutter_application_tfg/models/forum_section.dart';
import 'package:flutter_application_tfg/models/post.dart';

class PostArguments {
  Post post;
  ForumSection forumSection;
  String? id;
  bool userSession;

  PostArguments(
      {required this.post,
      required this.forumSection,
      this.id,
      required this.userSession});
}

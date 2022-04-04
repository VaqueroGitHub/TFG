import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/answer.dart';
import 'package:flutter_application_tfg/models/forum_section.dart';
import 'package:flutter_application_tfg/models/post.dart';
import 'package:flutter_application_tfg/services/answer_database_service.dart';
import 'package:flutter_application_tfg/services/forum_database_service.dart';
import 'package:flutter_application_tfg/services/post_database_service.dart';

class ForumListProvider extends ChangeNotifier {
  List<ForumSection> listForumSection = [];
  List<Post> listPosts = [];
  List<Answer> listAnswers = [];

  Future<List<ForumSection>> loadForumSections() async {
    return listForumSection = await ForumDatabaseService().getForumSections();
  }

  Future<List<Post>> loadPostList(String idForumSection) async {
    return listPosts =
        await PostDatabaseService().getPostsFromTopic(idForumSection);
  }

  Future<List<Post>> loadAllPostList() async {
    return listPosts = await PostDatabaseService().getAllPosts();
  }

  Future<List<Answer>> loadAnswerList(String idPost) async {
    return listAnswers = await AnswerDatabaseService().getAnswersPost(idPost);
  }

  List<Post> get posts {
    return listPosts;
  }

  List<ForumSection> get forumSections {
    return listForumSection;
  }

  List<Answer> get answers {
    return listAnswers;
  }
}

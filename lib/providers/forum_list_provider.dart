import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/helpers/debouncer.dart';
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

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Post>> _suggestionStreamContoller =
      new StreamController.broadcast();
  Stream<List<Post>> get suggestionStream =>
      this._suggestionStreamContoller.stream;

  Future<List<ForumSection>> loadForumSections() async {
    return listForumSection = await ForumDatabaseService().getForumSections();
  }

  Future<List<Post>> loadPostList(String idForumSection) async {
    listPosts = await PostDatabaseService().getPostsFromTopic(idForumSection);
    return listPosts;
  }

  Future<List<Post>> loadAllPostList() async {
    return listPosts = await PostDatabaseService().getAllPosts();
  }

  Future<List<Answer>> loadAnswerList(String idPost) async {
    return listAnswers = await AnswerDatabaseService().getAnswersPost(idPost);
  }

  void getSuggestionsByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await PostDatabaseService().getServicesByQuery(value);
      this._suggestionStreamContoller.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tfg/models/forum_section.dart';
import 'package:flutter_application_tfg/repository/forum_repository.dart';
import 'package:get_it/get_it.dart';

class ForumService {
  Future<List<ForumSection>> getForumSections() async {
    final QuerySnapshot forumCollection =
        await GetIt.I<ForumRepository>().getForumSections();

    List<ForumSection> listForumSections = [];
    for (var element in forumCollection.docs) {
      Map<dynamic, dynamic> forumSectionMap = element.data() as Map;
      ForumSection forumSection = ForumSection(
        title: forumSectionMap["title"],
        id: element.id,
      );

      listForumSections.add(forumSection);
    }

    return listForumSections;
  }

  Future<ForumSection?> getForumSection(String idForumSection) async {
    final resp =
        await GetIt.I<ForumRepository>().getForumSection(idForumSection);

    Map<dynamic, dynamic> forumSectionMap =
        resp.data() as Map<dynamic, dynamic>;
    if (forumSectionMap == null) return null;
    ForumSection forum =
        ForumSection(title: forumSectionMap['title'], id: resp.id);
    return forum;
  }
}

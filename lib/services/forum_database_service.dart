import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tfg/models/forum_section.dart';

class ForumDatabaseService {
  Future<List<ForumSection>> getForumSections() async {
    await Firebase.initializeApp();
    final QuerySnapshot forumCollection =
        await FirebaseFirestore.instance.collection("ForumSection").get();

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
    await Firebase.initializeApp();
    final resp = await FirebaseFirestore.instance
        .collection("ForumSection")
        .doc(idForumSection)
        .get();

    Map<dynamic, dynamic> forumSectionMap =
        resp.data() as Map<dynamic, dynamic>;
    if (forumSectionMap == null) return null;
    ForumSection forum =
        ForumSection(title: forumSectionMap['title'], id: resp.id);
    return forum;
  }
}

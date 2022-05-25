import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ForumRepository {
  final forumReference = FirebaseFirestore.instance.collection("ForumSection");

  Future<QuerySnapshot> getForumSections() async {
    await Firebase.initializeApp();
    return await forumReference.get();
  }

  Future<DocumentSnapshot> getForumSection(String idForumSection) async {
    return await forumReference.doc(idForumSection).get();
  }
}

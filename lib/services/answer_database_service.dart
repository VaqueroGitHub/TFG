import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tfg/models/answer.dart';

class AnswerDatabaseService {
  Future<Map<String, dynamic?>?> getAnswer(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference answerCollection =
        FirebaseFirestore.instance.collection("answer");

    final resp = await answerCollection.doc(uuid).get();
    final data = resp.data();
    if (data == null) return null;
    final Map<String, dynamic?>? doc = data as Map<String, dynamic?>;
    return doc;
  }

  Future updateAnswer(Answer answer, String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference answerCollection =
        FirebaseFirestore.instance.collection("answer");

    return await answerCollection.doc(uuid).set({'answer': answer.answer});
  }

  Future deletePost(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference answerCollection =
        FirebaseFirestore.instance.collection("answer");

    DocumentReference post = await answerCollection.doc(uuid);
    await post.delete();
  }

  Future<List<Map<dynamic, dynamic>>> getAnswersPost(String idPost) async {
    await Firebase.initializeApp();
    final QuerySnapshot answerCollection = await FirebaseFirestore.instance
        .collection("answer")
        .where('idPost', isEqualTo: idPost)
        .get();

    List<Map<dynamic, dynamic>> list =
        answerCollection.docs.map((doc) => doc.data()).cast<Map>().toList();

    return list;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerRepository {
  final answerReference = FirebaseFirestore.instance.collection("answer");

  Future<DocumentSnapshot> getAnswer(String uuid) async {
    return await answerReference.doc(uuid).get();
  }

  Future createAnswerMessage(Map<String, Object> answerMessage) async {
    return await answerReference.add(answerMessage);
  }

  Future updateAnswerMessage(
      Map<String, Object> answerMessage, String? uuid) async {
    return await answerReference.doc(uuid).set(answerMessage);
  }

  Future deleteAnswerMessage(String uuid) async {
    return await answerReference.doc(uuid).delete();
  }

  Future<QuerySnapshot> getAnswersPost(String idPost) async {
    return await answerReference
        .where('idPost', isEqualTo: idPost)
        .orderBy("datetime", descending: true)
        .get();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tfg/models/answer.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/user_database_service.dart';

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

  Future updateAnswer(Answer answer, String? uuid) async {
    await Firebase.initializeApp();
    final CollectionReference answerCollection =
        FirebaseFirestore.instance.collection("answer");

    if (uuid == null) {
      return await answerCollection.add({
        'answer': answer.answer,
        'idPost': answer.idPost,
        'idUser': answer.idUser,
      });
    }

    return await answerCollection.doc(uuid).set({
      'answer': answer.answer,
      'idPost': answer.idPost,
      'idUser': answer.idUser
    });
  }

  Future deletePost(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference answerCollection =
        FirebaseFirestore.instance.collection("answer");

    DocumentReference post = await answerCollection.doc(uuid);
    await post.delete();
  }

  Future<List<Answer>> getAnswersPost(String idPost) async {
    await Firebase.initializeApp();
    final QuerySnapshot answerCollection = await FirebaseFirestore.instance
        .collection("answer")
        .where('idPost', isEqualTo: idPost)
        .get();

    List<Answer> listAnswers = [];
    for (var element in answerCollection.docs) {
      Map<dynamic, dynamic> answerMap = element.data() as Map;
      User? user =
          await UserDatabaseService(uuid: answerMap['idUser']).getUserData();
      Answer answer = Answer(
        answer: answerMap['answer'],
        idPost: answerMap['idPost'],
        idUser: answerMap['idUser'],
        user: user,
        id: element.id,
      );

      listAnswers.add(answer);
    }

    return listAnswers;
  }
}

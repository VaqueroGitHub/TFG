import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tfg/models/answer.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/repository/answer_repository.dart';
import 'package:flutter_application_tfg/services/user_service.dart';
import 'package:get_it/get_it.dart';

class AnswerService {
  Future<Map<String, dynamic?>?> getAnswer(String uuid) async {
    final resp = await GetIt.I<AnswerRepository>().getAnswer(uuid);
    final data = resp.data();
    if (data == null) return null;
    final Map<String, dynamic?>? doc = data as Map<String, dynamic?>;
    return doc;
  }

  Future updateAnswer(Answer answer, String? uuid) async {
    if (uuid == null) {
      return await GetIt.I<AnswerRepository>().createAnswerMessage({
        'answer': answer.answer,
        'idPost': answer.idPost,
        'idUser': answer.idUser,
        'datetime': answer.datetime,
      });
    }

    return await GetIt.I<AnswerRepository>().updateAnswerMessage({
      'answer': answer.answer,
      'idPost': answer.idPost,
      'idUser': answer.idUser,
      'datetime': answer.datetime,
    }, uuid);
  }

  Future deletePost(String uuid) async {
    return await GetIt.I<AnswerRepository>().deleteAnswerMessage(uuid);
  }

  Future<List<Answer>> getAnswersPost(String idPost) async {
    final QuerySnapshot answerCollection =
        await GetIt.I<AnswerRepository>().getAnswersPost(idPost);

    List<Answer> listAnswers = [];
    for (var element in answerCollection.docs) {
      Map<dynamic, dynamic> answerMap = element.data() as Map;
      User? user =
          await GetIt.I<UserService>().getUserData(answerMap['idUser']);
      Answer answer = Answer(
        answer: answerMap['answer'],
        idPost: answerMap['idPost'],
        idUser: answerMap['idUser'],
        user: user,
        id: element.id,
        datetime: answerMap['datetime'],
      );

      listAnswers.add(answer);
    }

    return listAnswers;
  }
}

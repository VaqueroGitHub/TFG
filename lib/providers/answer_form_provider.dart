import 'package:flutter/widgets.dart';
import 'package:flutter_application_tfg/models/answer.dart';

class AnswerFormProvider extends ChangeNotifier {
  String answerBody = '';
  String idPost = '';
  String idUser = '';

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Answer answer() {
    return Answer(answer: answerBody, idPost: idPost, idUser: idUser);
  }
}

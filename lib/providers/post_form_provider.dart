import 'package:flutter/widgets.dart';
import 'package:flutter_application_tfg/models/post.dart';

class PostFormProvider extends ChangeNotifier {
  String title = '';
  String body = '';
  String idUser = '';
  String idForumSection = '';

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Post post() {
    return Post(
        title: title,
        body: body,
        idForumSection: idForumSection,
        idUser: idUser);
  }

  Post postWithId(String id) {
    return Post(
        id: id,
        title: title,
        body: body,
        idForumSection: idForumSection,
        idUser: idUser);
  }

  void setPost(Post post) {
    title = post.title;
    body = post.body;
    idUser = post.idUser;
    idForumSection = post.idForumSection;
  }

  void setEmptyPost(Post post) {
    title = '';
    body = '';
    idUser = '';
    idForumSection = '';
  }
}

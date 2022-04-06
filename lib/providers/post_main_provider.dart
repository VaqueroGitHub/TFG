import 'package:flutter/foundation.dart';
import 'package:flutter_application_tfg/models/post.dart';
import 'package:flutter_application_tfg/services/post_database_service.dart';

class PostMainProvider extends ChangeNotifier {
  late Post postMain;

  Future loadPost(String idPost) async {
    postMain = (await PostDatabaseService().getPostData(idPost))!;
  }

  Post get post {
    return postMain;
  }
}

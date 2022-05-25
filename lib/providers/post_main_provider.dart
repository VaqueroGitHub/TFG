import 'package:flutter/foundation.dart';
import 'package:flutter_application_tfg/models/post.dart';
import 'package:flutter_application_tfg/services/post_service.dart';
import 'package:get_it/get_it.dart';

class PostMainProvider extends ChangeNotifier {
  late Post postMain;

  Future loadPost(String idPost) async {
    postMain = (await GetIt.I<PostService>().getPostData(idPost))!;
  }

  Post get post {
    return postMain;
  }
}

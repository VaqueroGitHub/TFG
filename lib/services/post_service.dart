import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tfg/models/forum_section.dart';
import 'package:flutter_application_tfg/models/post.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/repository/post_repository.dart';
import 'package:flutter_application_tfg/services/answer_database_service.dart';
import 'package:flutter_application_tfg/services/forum_service.dart';
import 'package:flutter_application_tfg/services/user_service.dart';
import 'package:get_it/get_it.dart';

class PostService {
  Future updatePost(Post post, String idUser) async {
    if (post.id == null) {
      return await GetIt.I<PostRepository>().createPost({
        'title': post.title,
        'body': post.body,
        'idUser': post.idUser,
        'idForumSection': post.idForumSection,
      });
    }
    return await GetIt.I<PostRepository>().updatePost({
      'title': post.title,
      'body': post.body,
      'idUser': post.idUser,
      'idForumSection': post.idForumSection
    }, idUser);
  }

  Future deletePost(String uuid) async {
    return await GetIt.I<PostRepository>().deletePost(uuid);
  }

  Future<List<Post>> getAllPosts() async {
    final QuerySnapshot postCollection =
        await GetIt.I<PostRepository>().getAllPosts();

    List<Post> listPost = [];
    for (var element in postCollection.docs) {
      Map<dynamic, dynamic> postMap = element.data() as Map;
      bool answered =
          (await AnswerService().getAnswersPost(element.id)).isNotEmpty
              ? true
              : false;
      User? user = await GetIt.I<UserService>().getUserData(postMap['idUser']);
      ForumSection? forumSection = await GetIt.I<ForumService>()
          .getForumSection(postMap['idForumSection']);
      Post post = Post(
          title: postMap['title'],
          body: postMap['body'],
          idUser: postMap['idUser'],
          idForumSection: postMap['idForumSection'],
          answered: answered,
          user: user!,
          id: element.id,
          forumSection: forumSection);

      listPost.add(post);
    }

    return listPost;
  }

  Future<Post?> getPostData(String idPost) async {
    final resp = await GetIt.I<PostRepository>().getPostData(idPost);
    Map<dynamic, dynamic> postMap = resp.data() as Map<dynamic, dynamic>;
    if (postMap == null) return null;
    bool answered =
        (await GetIt.I<AnswerService>().getAnswersPost(idPost)).isNotEmpty
            ? true
            : false;
    User? user = await GetIt.I<UserService>().getUserData(postMap['idUser']);
    ForumSection? forumSection = await GetIt.I<ForumService>()
        .getForumSection(postMap['idForumSection']);
    Post post = Post(
        title: postMap['title'],
        body: postMap['body'],
        idUser: postMap['idUser'],
        idForumSection: postMap['idForumSection'],
        answered: answered,
        user: user!,
        id: resp.id,
        forumSection: forumSection);

    return post;
  }

  Future<List<Post>> getUserPosts(String idUser) async {
    final QuerySnapshot postCollection =
        await GetIt.I<PostRepository>().getUserPosts(idUser);

    List<Post> listPost = [];
    for (var element in postCollection.docs) {
      Map<dynamic, dynamic> postMap = element.data() as Map;
      bool answered =
          (await GetIt.I<AnswerService>().getAnswersPost(element.id)).isNotEmpty
              ? true
              : false;
      User? user = await GetIt.I<UserService>().getUserData(postMap['idUser']);
      ForumSection? forumSection = await GetIt.I<ForumService>()
          .getForumSection(postMap['idForumSection']);
      Post post = Post(
        title: postMap['title'],
        body: postMap['body'],
        idUser: postMap['idUser'],
        idForumSection: postMap['idForumSection'],
        answered: answered,
        user: user!,
        id: element.id,
        forumSection: forumSection,
      );

      listPost.add(post);
    }

    return listPost;
  }

  Future<List<Post>> getPostsFromTopic(String idForumSection) async {
    final QuerySnapshot postCollection =
        await GetIt.I<PostRepository>().getPostsFromTopic(idForumSection);

    List<Post> listPost = [];
    for (var element in postCollection.docs) {
      Map<dynamic, dynamic> postMap = element.data() as Map;
      bool answered =
          (await GetIt.I<AnswerService>().getAnswersPost(element.id)).isNotEmpty
              ? true
              : false;
      User? user = await GetIt.I<UserService>().getUserData(postMap['idUser']);
      ForumSection? forumSection = await GetIt.I<ForumService>()
          .getForumSection(postMap['idForumSection']);
      Post post = Post(
        title: postMap['title'],
        body: postMap['body'],
        idUser: postMap['idUser'],
        idForumSection: postMap['idForumSection'],
        answered: answered,
        user: user!,
        id: element.id,
        forumSection: forumSection,
      );

      listPost.add(post);
    }

    return listPost;
  }

  Future<List<Post>> getServicesByQuery(String query) async {
    final QuerySnapshot postCollection =
        await GetIt.I<PostRepository>().getServicesByQuery(query);

    List<Post> listPost = [];
    for (var element in postCollection.docs) {
      Map<dynamic, dynamic> postMap = element.data() as Map;
      bool answered =
          (await GetIt.I<AnswerService>().getAnswersPost(element.id)).isNotEmpty
              ? true
              : false;
      User? user = await GetIt.I<UserService>().getUserData(postMap['idUser']);
      ForumSection? forumSection = await GetIt.I<ForumService>()
          .getForumSection(postMap['idForumSection']);
      Post post = Post(
        title: postMap['title'],
        body: postMap['body'],
        idUser: postMap['idUser'],
        idForumSection: postMap['idForumSection'],
        answered: answered,
        user: user!,
        id: element.id,
        forumSection: forumSection,
      );

      listPost.add(post);
    }

    return listPost;
  }
}

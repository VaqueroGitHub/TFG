import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tfg/models/forum_section.dart';
import 'package:flutter_application_tfg/models/post.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/answer_database_service.dart';
import 'package:flutter_application_tfg/services/forum_database_service.dart';
import 'package:flutter_application_tfg/services/user_database_service.dart';

class PostDatabaseService {
  Future updatePost(Post post, String idUser) async {
    await Firebase.initializeApp();
    final CollectionReference postCollection =
        FirebaseFirestore.instance.collection("post");

    if (idUser == null) {
      return await postCollection.add({
        'title': post.title,
        'body': post.body,
        'idUser': post.idUser,
        'idForumSection': post.idForumSection,
      });
    }
    return await postCollection.doc().set({
      'title': post.title,
      'body': post.body,
      'idUser': post.idUser,
      'idForumSection': post.idForumSection
    });
  }

  Future deletePost(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference postCollection =
        FirebaseFirestore.instance.collection("post");

    DocumentReference post = await postCollection.doc(uuid);
    await post.delete();
  }

  Future<List<Post>> getAllPosts() async {
    await Firebase.initializeApp();
    final QuerySnapshot postCollection =
        await FirebaseFirestore.instance.collection("post").get();

    List<Post> listPost = [];
    for (var element in postCollection.docs) {
      Map<dynamic, dynamic> postMap = element.data() as Map;
      bool answered =
          (await AnswerDatabaseService().getAnswersPost(element.id)).isNotEmpty
              ? true
              : false;
      User? user =
          await UserDatabaseService(uuid: postMap['idUser']).getUserData();
      ForumSection? forumSection = await ForumDatabaseService()
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
    await Firebase.initializeApp();
    final resp =
        await FirebaseFirestore.instance.collection("post").doc(idPost).get();

    Map<dynamic, dynamic> postMap = resp.data() as Map<dynamic, dynamic>;
    if (postMap == null) return null;
    bool answered =
        (await AnswerDatabaseService().getAnswersPost(idPost)).isNotEmpty
            ? true
            : false;
    User? user =
        await UserDatabaseService(uuid: postMap['idUser']).getUserData();
    ForumSection? forumSection =
        await ForumDatabaseService().getForumSection(postMap['idForumSection']);
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
    await Firebase.initializeApp();
    final QuerySnapshot postCollection = await FirebaseFirestore.instance
        .collection("post")
        .where('idUser', isEqualTo: idUser)
        .get();

    List<Post> listPost = [];
    for (var element in postCollection.docs) {
      Map<dynamic, dynamic> postMap = element.data() as Map;
      bool answered =
          (await AnswerDatabaseService().getAnswersPost(element.id)).isNotEmpty
              ? true
              : false;
      User? user =
          await UserDatabaseService(uuid: postMap['idUser']).getUserData();
      ForumSection? forumSection = await ForumDatabaseService()
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
    await Firebase.initializeApp();
    final QuerySnapshot postCollection = await FirebaseFirestore.instance
        .collection("post")
        .where('idForumSection', isEqualTo: idForumSection)
        .get();

    List<Post> listPost = [];
    for (var element in postCollection.docs) {
      Map<dynamic, dynamic> postMap = element.data() as Map;
      bool answered =
          (await AnswerDatabaseService().getAnswersPost(element.id)).isNotEmpty
              ? true
              : false;
      User? user =
          await UserDatabaseService(uuid: postMap['idUser']).getUserData();
      ForumSection? forumSection = await ForumDatabaseService()
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

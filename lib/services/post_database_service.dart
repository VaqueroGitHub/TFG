import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tfg/models/forum_section.dart';
import 'package:flutter_application_tfg/models/post.dart';

class PostDatabaseService {
  Future<Map<String, dynamic?>?> getPost(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference postCollection =
        FirebaseFirestore.instance.collection("post");

    final resp = await postCollection.doc(uuid).get();
    final data = resp.data();
    if (data == null) return null;
    final Map<String, dynamic?>? doc = data as Map<String, dynamic?>;
    return doc;
  }

  Future updatePost(Post post, String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference postCollection =
        FirebaseFirestore.instance.collection("post");

    return await postCollection.doc(uuid).set({
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
    postCollection.docs.forEach((element) {
      Map<dynamic, dynamic> postMap = element.data() as Map;
      Post post = Post(
          title: postMap['title'],
          body: postMap['body'],
          idUser: postMap['idUser'],
          idForumSection: postMap['idForumSection'],
          id: element.id);

      listPost.add(post);
    });

    return listPost;
  }

  Future<Post?> getPostData(String idPost) async {
    await Firebase.initializeApp();
    final resp =
        await FirebaseFirestore.instance.collection("post").doc(idPost).get();

    Map<dynamic, dynamic> postMap = resp.data() as Map<dynamic, dynamic>;
    if (postMap == null) return null;
    Post post = Post(
        title: postMap['title'],
        body: postMap['body'],
        idUser: postMap['idUser'],
        idForumSection: postMap['idForumSection'],
        id: resp.id);

    return post;
  }

  Future<List<Post>> getUserPosts(String idUser) async {
    await Firebase.initializeApp();
    final QuerySnapshot postCollection = await FirebaseFirestore.instance
        .collection("post")
        .where('idUser', isEqualTo: idUser)
        .get();

    List<Post> listPost = [];
    postCollection.docs.forEach((element) {
      Map<dynamic, dynamic> postMap = element.data() as Map;
      Post post = Post(
          title: postMap['title'],
          body: postMap['body'],
          idUser: postMap['idUser'],
          idForumSection: postMap['idForumSection'],
          id: element.id);

      listPost.add(post);
    });

    return listPost;
  }

  Future<List<Post>> getPostsFromTopic(String idForumSection) async {
    await Firebase.initializeApp();
    final QuerySnapshot postCollection = await FirebaseFirestore.instance
        .collection("post")
        .where('idForumSection', isEqualTo: idForumSection)
        .get();

    List<Post> listPost = [];
    postCollection.docs.forEach((element) {
      Map<dynamic, dynamic> postMap = element.data() as Map;
      Post post = Post(
          title: postMap['title'],
          body: postMap['body'],
          idUser: postMap['idUser'],
          idForumSection: postMap['idForumSection'],
          id: element.id);

      listPost.add(post);
    });

    return listPost;
  }

  Future<List<ForumSection>> getForumSections(String idForumSection) async {
    await Firebase.initializeApp();
    final QuerySnapshot forumSections =
        await FirebaseFirestore.instance.collection("ForumSection").get();

    List<ForumSection> forumSectionList = [];
    forumSections.docs.forEach((element) {
      Map<dynamic, dynamic> forumSectionMap = element.data() as Map;
      ForumSection forumSection =
          ForumSection(title: forumSectionMap['title'], id: element.id);
      forumSectionList.add(forumSection);
    });

    return forumSectionList;
  }

  Future<List<Post>> getAllUsersAdmin() async {
    await Firebase.initializeApp();
    final QuerySnapshot postCollection =
        await FirebaseFirestore.instance.collection("post").get();

    List<Post> listPost = [];
    postCollection.docs.forEach((element) {
      Map<dynamic, dynamic> postMap = element.data() as Map;
      Post post = Post(
          title: postMap['title'],
          body: postMap['body'],
          idUser: postMap['idUser'],
          idForumSection: postMap['idForumSection'],
          id: element.id);

      listPost.add(post);
    });

    return listPost;
  }
}

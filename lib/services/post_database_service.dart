import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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

    return await postCollection
        .doc(uuid)
        .set({'title': post.title, 'body': post.body});
  }

  Future deletePost(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference postCollection =
        FirebaseFirestore.instance.collection("post");

    DocumentReference post = await postCollection.doc(uuid);
    await post.delete();
  }

  Future<List<Map<dynamic, dynamic>>> getAllPosts() async {
    await Firebase.initializeApp();
    final QuerySnapshot postCollection =
        await FirebaseFirestore.instance.collection("post").get();

    List<Map<dynamic, dynamic>> list =
        postCollection.docs.map((doc) => doc.data()).cast<Map>().toList();

    return list;
  }
}

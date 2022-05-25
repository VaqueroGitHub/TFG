import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepository {
  final postReference = FirebaseFirestore.instance.collection("post");

  Future createPost(Map<String, String> post) async {
    return await postReference.add(post);
  }

  Future updatePost(Map<String, String> post, String idUser) async {
    return await postReference.doc(idUser).set(post);
  }

  Future deletePost(String uuid) async {
    return await postReference.doc(uuid).delete();
  }

  Future<QuerySnapshot> getAllPosts() async {
    return await postReference.get();
  }

  Future<DocumentSnapshot> getPostData(String idPost) async {
    return await postReference.doc(idPost).get();
  }

  Future<QuerySnapshot> getUserPosts(String idUser) async {
    return await postReference.where('idUser', isEqualTo: idUser).get();
  }

  Future<QuerySnapshot> getPostsFromTopic(String idForumSection) async {
    return await postReference
        .where('idForumSection', isEqualTo: idForumSection)
        .get();
  }

  Future<QuerySnapshot> getServicesByQuery(String query) async {
    return await postReference.where("title", isEqualTo: query).get();
  }
}

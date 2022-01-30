import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tfg/models/user.dart';

class DatabaseService {
  final String uuid;

  DatabaseService({required this.uuid});

  Future<Map<String, dynamic?>?> getUserData() async {
    await Firebase.initializeApp();
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection("users");

    final resp = await userCollection.doc(uuid).get();
    final data = resp.data();
    if (data == null) return null;
    final Map<String, dynamic?>? doc = data as Map<String, dynamic?>;
    return doc;
  }

  Future updateUserData(User user) async {
    await Firebase.initializeApp();
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection("users");
    if (user.isAdmin) {
      return await userCollection.doc(uuid).set({
        'name': user.fullName,
        'email': user.email,
        'password': user.password,
        'nick': user.nick,
        'isAdmin': true,
      });
    } else {
      return await userCollection.doc(uuid).set({
        'name': user.fullName,
        'email': user.email,
        'password': user.password,
        'nick': user.nick,
        'isAdmin': false,
      });
    }
  }

  Future<List<Map<dynamic, dynamic>>> getAllUsersAdmin() async {
    await Firebase.initializeApp();
    final QuerySnapshot userCollection = await FirebaseFirestore.instance
        .collection("users")
        .where('isAdmin', isEqualTo: false)
        .get();

    List<Map<dynamic, dynamic>> list =
        userCollection.docs.map((doc) => doc.data()).cast<Map>().toList();

    return list;
  }

  Future deleteUser(String uid) async {
    await Firebase.initializeApp();
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection("users");

    DocumentReference user = await userCollection.doc(uuid);
    await user.delete();
  }
}

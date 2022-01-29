import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tfg/models/user.dart';

class DatabaseService {
  final String uuid;

  DatabaseService({required this.uuid});

  Future<bool> getUserData() async {
    await Firebase.initializeApp();
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection("users");
    print(uuid);
    final resp = await userCollection.doc(uuid).get();
    final Map<String, dynamic?> doc = resp.data() as Map<String, dynamic?>;
    return doc['isAdmin'] ?? false;
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
}

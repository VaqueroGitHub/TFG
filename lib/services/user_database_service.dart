import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';

class UserDatabaseService {
  final String uuid;

  UserDatabaseService({required this.uuid});

  Future<User?> getUserData() async {
    await Firebase.initializeApp();
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection("users");
    //await AuthService().logout();
    final resp = await userCollection.doc(uuid).get();
    Map<dynamic, dynamic> data = resp.data() as Map<dynamic, dynamic>;
    if (data == null) return null;
    User user = User(
        nick: data["nick"],
        fullName: data["name"],
        email: data["email"],
        password: data["password"],
        isAdmin: data["isAdmin"],
        bio: data["bio"],
        id: resp.id);

    return user;
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
        "bio": user.bio,
      });
    } else {
      return await userCollection.doc(uuid).set({
        'name': user.fullName,
        'email': user.email,
        'password': user.password,
        'nick': user.nick,
        'isAdmin': false,
        "bio": user.bio,
      });
    }
  }

  Future<List<User>> getAllUsersAdmin() async {
    await Firebase.initializeApp();
    final QuerySnapshot userCollection = await FirebaseFirestore.instance
        .collection("users")
        .where('isAdmin', isEqualTo: false)
        .get();

    List<User> listUser = [];
    userCollection.docs.forEach((element) {
      Map<dynamic, dynamic> userMap = element.data() as Map;
      User user = User(
          nick: userMap["nick"],
          fullName: userMap["name"],
          email: userMap["email"],
          password: userMap["password"],
          isAdmin: userMap["isAdmin"],
          bio: userMap["bio"],
          id: element.id);
      listUser.add(user);
    });

    return listUser;
  }

  Future deleteUser() async {
    await Firebase.initializeApp();
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection("users");

    DocumentReference user = await userCollection.doc(uuid);
    //Borrar grupos
    //Borrar posts
    //Borrar servicios
    await user.delete();
  }
}

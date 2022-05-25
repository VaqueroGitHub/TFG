import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';

import '../models/user.dart';

class UserRepository {
  final usersReference = FirebaseFirestore.instance.collection("users");

  Future<DocumentSnapshot> getUserData(String uuid) async {
    return await usersReference.doc(uuid).get();
  }

  Future<dynamic> updateUser(Map<String, Object?> user, String uuid) async {
    return await usersReference.doc(uuid).set(user);
  }

  Future<List<User>> getAllUsersAdmin() async {
    final QuerySnapshot userCollection = await usersReference
        .where('isAdmin', isEqualTo: false)
        .where('active', isEqualTo: true)
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
          id: element.id,
          url: userMap["url"]);
      listUser.add(user);
    });

    return listUser;
  }

  Future delete(String userId) async {
    return await usersReference.doc(userId);
  }
}

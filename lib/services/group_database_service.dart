import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tfg/models/group.dart';

class GroupDatabaseService {
  Future<Map<String, dynamic?>?> getGroup(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference groupCollection =
        FirebaseFirestore.instance.collection("group");

    final resp = await groupCollection.doc(uuid).get();
    final data = resp.data();
    if (data == null) return null;
    final Map<String, dynamic?>? doc = data as Map<String, dynamic?>;
    return doc;
  }

  Future updateGroup(Group group, String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference groupCollection =
        FirebaseFirestore.instance.collection("group");

    return await groupCollection.doc(uuid).set({
      "asignatura": group.asignatura,
      "year": group.year,
      "description": group.description,
      "nMembersRequired": group.nMembersRequired,
      "idMembers": group.idMembers,
      "idUser": group.idUser,
    });
  }

  Future deleteGroup(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference groupCollection =
        FirebaseFirestore.instance.collection("group");

    DocumentReference post = await groupCollection.doc(uuid);
    await post.delete();
  }

  Future<List<Map<dynamic, dynamic>>> getUserGroups(String idUser) async {
    await Firebase.initializeApp();
    final QuerySnapshot ownGroupCollection = await FirebaseFirestore.instance
        .collection("group")
        .where('idUser', isEqualTo: idUser)
        .get();
    final QuerySnapshot joinedGroupCollection = await FirebaseFirestore.instance
        .collection("group")
        .where('idUser', isNotEqualTo: idUser)
        .where('nMembersRequired', arrayContains: idUser)
        .get();

    List<Map<dynamic, dynamic>> listOwnGroups =
        ownGroupCollection.docs.map((doc) => doc.data()).cast<Map>().toList();
    List<Map<dynamic, dynamic>> listJoinedGroups = joinedGroupCollection.docs
        .map((doc) => doc.data())
        .cast<Map>()
        .toList();

    List<Map<dynamic, dynamic>> joinedList = List.from(listJoinedGroups)
      ..addAll(listOwnGroups);

    return joinedList;
  }
}

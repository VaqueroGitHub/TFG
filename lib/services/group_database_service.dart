import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tfg/models/group.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/user_database_service.dart';

class GroupDatabaseService {
  Future<Group?> getGroup(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference groupCollection =
        FirebaseFirestore.instance.collection("group");

    final resp = await groupCollection.doc(uuid).get();
    final data = resp.data() as Map<String, dynamic?>;
    if (data == null) return null;
    Group group = Group(
      asignatura: data['asignatura'],
      year: data['year'],
      description: data['description'],
      nMembersRequired: data['nMembersRequired'],
      idMembers: data['idMembers'],
      idUser: data['idUser'],
      id: resp.id,
      driveUrl: data['driveUrl'],
      githUrl: data['githUrl'],
    );

    return group;
  }

  Future updateGroup(Group group, String? uuid) async {
    await Firebase.initializeApp();
    final CollectionReference groupCollection =
        FirebaseFirestore.instance.collection("group");

    if (uuid == null) {
      return await groupCollection.add({
        "asignatura": group.asignatura,
        "year": group.year,
        "description": group.description,
        "nMembersRequired": group.nMembersRequired,
        "githUrl": group.githUrl,
        "driveUrl": group.driveUrl,
        "idMembers": group.idMembers,
        "idUser": group.idUser,
      });
    }
    return await groupCollection.doc(uuid).set({
      "asignatura": group.asignatura,
      "year": group.year,
      "description": group.description,
      "githUrl": group.githUrl,
      "driveUrl": group.driveUrl,
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

  Future joinGroup(Group group, String idUser) async {
    await Firebase.initializeApp();
    final CollectionReference groupCollection =
        FirebaseFirestore.instance.collection("group");

    if (!group.idMembers.contains(idUser)) group.idMembers.add(idUser);

    return await groupCollection.doc(group.id).set({
      "asignatura": group.asignatura,
      "year": group.year,
      "description": group.description,
      "githUrl": group.githUrl,
      "driveUrl": group.driveUrl,
      "nMembersRequired": group.nMembersRequired,
      "idMembers": group.idMembers,
      "idUser": group.idUser,
    });
  }

  Future exitGroup(Group group, String idUser) async {
    await Firebase.initializeApp();
    final CollectionReference groupCollection =
        FirebaseFirestore.instance.collection("group");

    if (group.idMembers.contains(idUser)) group.idMembers.remove(idUser);

    return await groupCollection.doc(group.id).set({
      "asignatura": group.asignatura,
      "year": group.year,
      "description": group.description,
      "nMembersRequired": group.nMembersRequired,
      "githUrl": group.githUrl,
      "driveUrl": group.driveUrl,
      "idMembers": group.idMembers,
      "idUser": group.idUser,
    });
  }

  Future<List<Group>> getUserGroups(String idUser) async {
    await Firebase.initializeApp();
    final QuerySnapshot ownGroupCollection = await FirebaseFirestore.instance
        .collection("group")
        .where('idUser', isEqualTo: idUser)
        .get();
    final QuerySnapshot joinedGroupCollection = await FirebaseFirestore.instance
        .collection("group")
        .where('idUser', isNotEqualTo: idUser)
        .where('idMembers', arrayContains: idUser)
        .get();

    List<Group> listOwnGroups = [];
    for (var element in ownGroupCollection.docs) {
      Map<dynamic, dynamic> groupMap = element.data() as Map;
      User? user =
          await UserDatabaseService(uuid: groupMap['idUser']).getUserData();
      Group group = Group(
          asignatura: groupMap['asignatura'],
          year: groupMap['year'],
          description: groupMap['description'],
          nMembersRequired: groupMap['nMembersRequired'],
          idMembers: (groupMap['idMembers'] as List<dynamic>).cast<String>(),
          driveUrl: groupMap['driveUrl'],
          githUrl: groupMap['githUrl'],
          idUser: groupMap['idUser'],
          id: element.id,
          user: user);

      listOwnGroups.add(group);
    }

    List<Group> listJoinedGroups = [];
    for (var element in joinedGroupCollection.docs) {
      Map<dynamic, dynamic> groupMap = element.data() as Map;
      User? user =
          await UserDatabaseService(uuid: groupMap['idUser']).getUserData();
      Group group = Group(
          asignatura: groupMap['asignatura'],
          year: groupMap['year'],
          description: groupMap['description'],
          nMembersRequired: groupMap['nMembersRequired'],
          idMembers: (groupMap['idMembers'] as List<dynamic>).cast<String>(),
          driveUrl: groupMap['driveUrl'],
          githUrl: groupMap['githUrl'],
          idUser: groupMap['idUser'],
          id: element.id,
          user: user);

      listJoinedGroups.add(group);
    }

    List<Group> joinedList = List.from(listJoinedGroups)..addAll(listOwnGroups);

    return joinedList;
  }

  Future<List<Group>> getAllGroups() async {
    await Firebase.initializeApp();
    final QuerySnapshot groupCollection =
        await FirebaseFirestore.instance.collection("group").get();

    List<Group> listOwnGroups = [];
    for (var element in groupCollection.docs) {
      Map<dynamic, dynamic> groupMap = element.data() as Map;
      User? user =
          await UserDatabaseService(uuid: groupMap['idUser']).getUserData();
      Group group = Group(
          asignatura: groupMap['asignatura'],
          year: groupMap['year'],
          description: groupMap['description'],
          nMembersRequired: groupMap['nMembersRequired'],
          idMembers: (groupMap['idMembers'] as List<dynamic>).cast<String>(),
          driveUrl: groupMap['driveUrl'],
          githUrl: groupMap['githUrl'],
          idUser: groupMap['idUser'],
          id: element.id,
          user: user);

      listOwnGroups.add(group);
    }

    return listOwnGroups;
  }
}

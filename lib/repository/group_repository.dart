import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tfg/models/group.dart';

class GroupRepository {
  final groupReference = FirebaseFirestore.instance.collection("group");

  Future<DocumentSnapshot> getGroup(String uuid) async {
    return await groupReference.doc(uuid).get();
  }

  Future<dynamic> createGroup(Map<String, Object?> group) async {
    return await groupReference.add(group);
  }

  Future<dynamic> updateGroup(Map<String, Object?> group, String uuid) async {
    return await groupReference.doc(uuid).set(group);
  }

  Future deleteGroup(String uuid) async {
    return await groupReference.doc(uuid).delete();
  }

  Future joinGroup(Map<String, dynamic> group, String idUser) async {
    return await groupReference.doc(idUser).set(group);
  }

  Future exitGroup(Map<String, dynamic> group, String idUser) async {
    return await groupReference.doc(idUser).set(group);
  }

  Future<QuerySnapshot> getUserOwnGroups(String idUser) async {
    return await groupReference.where('idUser', isEqualTo: idUser).get();
  }

  Future<QuerySnapshot> getUserJoinedGroups(String idUser) async {
    return await groupReference
        .where('idUser', isNotEqualTo: idUser)
        .where('idMembers', arrayContains: idUser)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllGroups() async {
    return await groupReference.get();
  }

  Future<QuerySnapshot> getGroupsByAsignatura(String query) async {
    return await groupReference.where("asignatura", isEqualTo: query).get();
  }
}

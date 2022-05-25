import 'package:cloud_firestore/cloud_firestore.dart';

class MessageGroupRepository {
  final groupReference = FirebaseFirestore.instance.collection("MessageGroup");

  Future<DocumentSnapshot> getMessage(String uuid) async {
    return await groupReference.doc(uuid).get();
  }

  Future createGroupMessage(Map<String, Object> groupMessage) async {
    return await groupReference.add(groupMessage);
  }

  Future updateGroupMessage(
      Map<String, Object> groupMessage, String? uuid) async {
    return await groupReference.doc(uuid).set(groupMessage);
  }

  Future deleteGroupMessage(String uuid) async {
    return await groupReference.doc(uuid).delete();
  }

  Future<QuerySnapshot> getGroupMessages(String idGroup) async {
    return await groupReference
        .where('idGroup', isEqualTo: idGroup)
        .orderBy("datetime", descending: true)
        .get();
  }
}

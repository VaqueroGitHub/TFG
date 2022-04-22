import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tfg/models/group_message.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/user_database_service.dart';

class MessageGroupDatabaseService {
  Future<Map<String, dynamic?>?> getMessage(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference messageGroupCollection =
        FirebaseFirestore.instance.collection("MessageGroup");

    final resp = await messageGroupCollection.doc(uuid).get();
    final data = resp.data();
    if (data == null) return null;
    final Map<String, dynamic?>? doc = data as Map<String, dynamic?>;
    return doc;
  }

  Future updateGroupMessage(GroupMessage groupMessage, String? uuid) async {
    await Firebase.initializeApp();
    final CollectionReference messageGroupCollection =
        FirebaseFirestore.instance.collection("MessageGroup");

    if (uuid == null) {
      return await messageGroupCollection.add({
        'message': groupMessage.message,
        'idGroup': groupMessage.idGroup,
        'idUser': groupMessage.idUser,
        'datetime': groupMessage.datetime,
      });
    }

    return await messageGroupCollection.doc(uuid).set({
      'message': groupMessage.message,
      'idGroup': groupMessage.idGroup,
      'idUser': groupMessage.idUser,
      'datetime': groupMessage.datetime,
    });
  }

  Future deleteGroupMessage(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference messageGroupCollection =
        FirebaseFirestore.instance.collection("MessageGroup");

    DocumentReference post = await messageGroupCollection.doc(uuid);
    await post.delete();
  }

  Future<List<GroupMessage>> getGroupMessages(String idGroup) async {
    await Firebase.initializeApp();
    final QuerySnapshot messageGroupCollection = await FirebaseFirestore
        .instance
        .collection("MessageGroup")
        .where('idGroup', isEqualTo: idGroup)
        .orderBy("datetime", descending: true)
        .get();

    List<GroupMessage> listMessages = [];
    for (var element in messageGroupCollection.docs) {
      Map<dynamic, dynamic> messageMap = element.data() as Map;
      User? user =
          await UserDatabaseService(uuid: messageMap['idUser']).getUserData();
      GroupMessage groupMessage = GroupMessage(
        message: messageMap['message'],
        idGroup: messageMap['idGroup'],
        idUser: messageMap['idUser'],
        user: user,
        id: element.id,
        datetime: messageMap['datetime'],
      );

      listMessages.add(groupMessage);
    }

    return listMessages;
  }
}

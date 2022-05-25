import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tfg/models/group_message.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/repository/message_group_repository.dart';
import 'package:flutter_application_tfg/services/user_service.dart';
import 'package:get_it/get_it.dart';

class MessageGroupService {
  Future<Map<String, dynamic?>?> getMessage(String uuid) async {
    final resp = await GetIt.I<MessageGroupRepository>().getMessage(uuid);
    final data = resp.data();
    if (data == null) return null;
    final Map<String, dynamic?>? doc = data as Map<String, dynamic?>;
    return doc;
  }

  Future updateGroupMessage(GroupMessage groupMessage, String? uuid) async {
    if (uuid == null) {
      return await GetIt.I<MessageGroupRepository>().createGroupMessage({
        'message': groupMessage.message,
        'idGroup': groupMessage.idGroup,
        'idUser': groupMessage.idUser,
        'datetime': groupMessage.datetime,
      });
    }

    return await GetIt.I<MessageGroupRepository>().updateGroupMessage({
      'message': groupMessage.message,
      'idGroup': groupMessage.idGroup,
      'idUser': groupMessage.idUser,
      'datetime': groupMessage.datetime,
    }, uuid);
  }

  Future deleteGroupMessage(String uuid) async {
    return await GetIt.I<MessageGroupRepository>().deleteGroupMessage(uuid);
  }

  Future<List<GroupMessage>> getGroupMessages(String idGroup) async {
    final QuerySnapshot messageGroupCollection =
        await GetIt.I<MessageGroupRepository>().getGroupMessages(idGroup);

    List<GroupMessage> listMessages = [];
    for (var element in messageGroupCollection.docs) {
      Map<dynamic, dynamic> messageMap = element.data() as Map;
      User? user =
          await GetIt.I<UserService>().getUserData(messageMap['idUser']);
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

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/group.dart';
import 'package:flutter_application_tfg/models/group_message.dart';
import 'package:flutter_application_tfg/services/group_database_service.dart';
import 'package:flutter_application_tfg/services/message_group_database_service.dart';

class GroupListProvider extends ChangeNotifier {
  List<Group> listGroup = [];
  List<GroupMessage> messageList = [];

  Future<List<Group>> loadAllGroupList() async {
    return listGroup = await GroupDatabaseService().getAllGroups();
  }

  Future<List<Group>> loadUserGroupList(String idUser) async {
    return listGroup = await GroupDatabaseService().getUserGroups(idUser);
  }

  Future<List<GroupMessage>> loadMessagesGroupList(String idGroup) async {
    messageList = await MessageGroupDatabaseService().getGroupMessages(idGroup);
    notifyListeners();
    return messageList;
  }

  List<Group> get list {
    return listGroup;
  }

  List<GroupMessage> get listMessage {
    return messageList;
  }
}

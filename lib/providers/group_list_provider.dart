import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/helpers/debouncer.dart';
import 'package:flutter_application_tfg/models/group.dart';
import 'package:flutter_application_tfg/models/group_message.dart';
import 'package:flutter_application_tfg/services/group_database_service.dart';
import 'package:flutter_application_tfg/services/message_group_database_service.dart';

class GroupListProvider extends ChangeNotifier {
  List<Group> listGroup = [];
  List<GroupMessage> messageList = [];

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Group>> _suggestionStreamContoller =
      new StreamController.broadcast();
  Stream<List<Group>> get suggestionStream =>
      this._suggestionStreamContoller.stream;

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

  void getSuggestionsByQueryAsignatura(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results =
          await GroupDatabaseService().getServicesByQueryAsignatura(value);
      this._suggestionStreamContoller.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  List<Group> get list {
    return listGroup;
  }

  List<GroupMessage> get listMessage {
    return messageList;
  }
}

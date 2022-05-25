import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/helpers/debouncer.dart';
import 'package:flutter_application_tfg/models/group.dart';
import 'package:flutter_application_tfg/models/group_message.dart';
import 'package:flutter_application_tfg/services/group_service.dart';
import 'package:flutter_application_tfg/services/message_group_service.dart';
import 'package:get_it/get_it.dart';

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
    return listGroup = await GetIt.I<GroupService>().getAllGroups();
  }

  Future<List<Group>> loadUserGroupList(String idUser) async {
    return listGroup = await GetIt.I<GroupService>().getUserGroups(idUser);
  }

  Future<List<GroupMessage>> loadMessagesGroupList(String idGroup) async {
    messageList =
        await GetIt.I<MessageGroupService>().getGroupMessages(idGroup);
    notifyListeners();
    return messageList;
  }

  void getSuggestionsByQueryAsignatura(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results =
          await GetIt.I<GroupService>().getServicesByQueryAsignatura(value);
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

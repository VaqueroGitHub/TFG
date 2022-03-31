import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/group.dart';
import 'package:flutter_application_tfg/services/group_database_service.dart';

class GroupListProvider extends ChangeNotifier {
  List<Group> listGroup = [];

  Future<List<Group>> loadAllGroupList() async {
    return listGroup = await GroupDatabaseService().getAllGroups();
  }

  Future<List<Group>> loadUserGroupList(String idUser) async {
    return listGroup = await GroupDatabaseService().getUserGroups(idUser);
  }

  List<Group> get list {
    return listGroup;
  }
}

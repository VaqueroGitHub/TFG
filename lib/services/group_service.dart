import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tfg/models/group.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/repository/group_repository.dart';
import 'package:flutter_application_tfg/services/user_service.dart';
import 'package:get_it/get_it.dart';

class GroupService {
  Future<Group?> getGroup(String uuid) async {
    final resp = await GetIt.I<GroupRepository>().getGroup(uuid);
    final data = resp.data() as Map<String, dynamic?>;
    if (data == null) return null;
    User? user = await GetIt.I<UserService>().getUserData(data['idUser']);
    Group group = Group(
        asignatura: data['asignatura'],
        year: data['year'],
        description: data['description'],
        nMembersRequired: data['nMembersRequired'],
        idMembers: (data['idMembers'] as List<dynamic>).cast<String>(),
        idUser: data['idUser'],
        id: resp.id,
        driveUrl: data['driveUrl'],
        githUrl: data['githUrl'],
        user: user);

    return group;
  }

  Future updateGroup(Group group, String? uuid) async {
    if (uuid == null) {
      return await GetIt.I<GroupRepository>().createGroup({
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
    return await GetIt.I<GroupRepository>().updateGroup({
      "asignatura": group.asignatura,
      "year": group.year,
      "description": group.description,
      "githUrl": group.githUrl,
      "driveUrl": group.driveUrl,
      "nMembersRequired": group.nMembersRequired,
      "idMembers": group.idMembers,
      "idUser": group.idUser,
    }, uuid);
  }

  Future deleteGroup(String uuid) async {
    await GetIt.I<GroupRepository>().deleteGroup(uuid);
  }

  Future joinGroup(Group group, String idUser) async {
    if (!group.idMembers.contains(idUser)) group.idMembers.add(idUser);

    return await GetIt.I<GroupRepository>().joinGroup({
      "asignatura": group.asignatura,
      "year": group.year,
      "description": group.description,
      "githUrl": group.githUrl,
      "driveUrl": group.driveUrl,
      "nMembersRequired": group.nMembersRequired,
      "idMembers": group.idMembers,
      "idUser": group.idUser,
    }, group.idUser);
  }

  Future exitGroup(Group group, String idUser) async {
    if (group.idMembers.contains(idUser)) group.idMembers.remove(idUser);

    return await GetIt.I<GroupRepository>().exitGroup({
      "asignatura": group.asignatura,
      "year": group.year,
      "description": group.description,
      "nMembersRequired": group.nMembersRequired,
      "githUrl": group.githUrl,
      "driveUrl": group.driveUrl,
      "idMembers": group.idMembers,
      "idUser": group.idUser,
    }, group.idUser);
  }

  Future<List<Group>> getUserGroups(String idUser) async {
    final QuerySnapshot owngroupReference =
        await GetIt.I<GroupRepository>().getUserOwnGroups(idUser);
    final QuerySnapshot joinedgroupReference =
        await GetIt.I<GroupRepository>().getUserJoinedGroups(idUser);

    List<Group> listOwnGroups = [];
    for (var element in owngroupReference.docs) {
      Map<dynamic, dynamic> groupMap = element.data() as Map;
      User? user = await GetIt.I<UserService>().getUserData(groupMap['idUser']);
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
    for (var element in joinedgroupReference.docs) {
      Map<dynamic, dynamic> groupMap = element.data() as Map;
      User? user = await GetIt.I<UserService>().getUserData(groupMap['idUser']);
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
    QuerySnapshot<Map<String, dynamic>> allGroups =
        await GetIt.I<GroupRepository>().getAllGroups();
    List<Group> listOwnGroups = [];
    for (var element in (allGroups).docs) {
      Map<dynamic, dynamic> groupMap = element.data() as Map;
      User? user = await GetIt.I<UserService>().getUserData(groupMap['idUser']);
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

  Future<List<User>> getMembersGroup(List<String> idMembers) async {
    List<User> listUser = [];
    for (String idUser in idMembers) {
      User? user = await GetIt.I<UserService>().getUserData(idUser);
      listUser.add(user!);
    }

    return listUser;
  }

  Future<List<Group>> getServicesByQueryAsignatura(String query) async {
    final QuerySnapshot groups =
        await GetIt.I<GroupRepository>().getGroupsByAsignatura(query);

    List<Group> listOwnGroups = [];
    for (var element in groups.docs) {
      Map<dynamic, dynamic> groupMap = element.data() as Map;
      User? user = await GetIt.I<UserService>().getUserData(groupMap['idUser']);
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

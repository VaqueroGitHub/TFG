import 'package:flutter_application_tfg/models/group.dart';

class GroupArguments {
  Group? group;
  String? id;
  bool userSession;
  bool isEditing;

  GroupArguments(
      {this.group,
      this.id,
      required this.userSession,
      required this.isEditing});
}

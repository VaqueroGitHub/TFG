import 'package:flutter_application_tfg/models/group.dart';

class GroupArguments {
  Group group;
  String? id;
  bool userSession;

  GroupArguments({required this.group, this.id, required this.userSession});
}

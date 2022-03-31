import 'package:flutter_application_tfg/models/user.dart';

class UserArguments {
  User user;
  String id;
  bool userSession;

  UserArguments(
      {required this.user, required this.id, required this.userSession});
}

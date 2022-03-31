import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_application_tfg/services/user_database_service.dart';

class UserSessionProvider extends ChangeNotifier {
  late User userSession;

  User get user {
    return userSession;
  }

  void set user(User user) {
    userSession = user;
  }

  Future loadUserInfo() async {
    var userId = await AuthService().getUserId();
    userSession = (await UserDatabaseService(uuid: userId).getUserData())!;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';

class UserSessionProvider extends ChangeNotifier {
  late String id;
  late User userSession;

  User get user {
    return userSession;
  }

  void set user(User user) {
    userSession = user;
  }

  String get userId {
    return id;
  }

  void set userId(String userId) {
    id = userId;
  }

  void loadUserInfo() async {
    userSession = await AuthService().getUser();
    id = await AuthService().getUserId();
  }
}

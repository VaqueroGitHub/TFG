import 'package:flutter/widgets.dart';
import 'package:flutter_application_tfg/models/user.dart';

class UserRegisterProvider extends ChangeNotifier {
  String nick = '';
  String fullName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String bio = 'Insert here your bio..';

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  User user() {
    return User(
        nick: nick,
        fullName: fullName,
        email: email,
        password: password,
        isAdmin: false,
        bio: bio);
  }
}

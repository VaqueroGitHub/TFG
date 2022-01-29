import 'package:flutter/widgets.dart';

class UserLoginProvider extends ChangeNotifier {
  String email = '';
  String password = '';

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}

import 'package:flutter/material.dart';

class EmailPassFormProvider extends ChangeNotifier {
  String email = '';
  String password = '';
  String confirmPassword = '';

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}

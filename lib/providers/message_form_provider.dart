import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_tfg/models/group_message.dart';
import 'package:flutter_application_tfg/models/service_message.dart';

class MessageFormProvider extends ChangeNotifier {
  String message = '';
  String idGroup = '';
  String idService = '';
  String idUser = '';

  GlobalKey<FormState> groupFormKey = GlobalKey();
  GlobalKey<FormState> serviceFormKey = GlobalKey();

  bool isLoading = false;

  bool isValidGroupForm() {
    return groupFormKey.currentState?.validate() ?? false;
  }

  GroupMessage groupMessage() {
    return GroupMessage(
      message: message,
      idGroup: idGroup,
      idUser: idUser,
      datetime: Timestamp.fromDate(DateTime.now()),
    );
  }

  ServiceMessage serviceMessage() {
    return ServiceMessage(
      message: message,
      idService: idService,
      idUser: idUser,
      datetime: Timestamp.fromDate(DateTime.now()),
    );
  }
}

import 'package:flutter_application_tfg/models/service.dart';

class ServiceArguments {
  Service? service;
  String? id;
  bool userSession;
  bool isEditing;

  ServiceArguments(
      {this.service,
      this.id,
      required this.userSession,
      required this.isEditing});
}

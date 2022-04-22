import 'package:flutter_application_tfg/models/service.dart';

class ServiceArguments {
  Service service;
  String? id;
  bool userSession;

  ServiceArguments({required this.service, this.id, required this.userSession});
}

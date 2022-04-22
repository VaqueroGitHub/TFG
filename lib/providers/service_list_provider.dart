import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/models/service_message.dart';
import 'package:flutter_application_tfg/services/message_service_database_service.dart';
import 'package:flutter_application_tfg/services/service_database_service.dart';

class ServiceListProvider extends ChangeNotifier {
  List<Service> listService = [];
  List<ServiceMessage> messageList = [];

  Future<List<Service>> loadAllServiceList() async {
    return listService = await ServiceDatabaseService().getAllServices();
  }

  Future<List<Service>> loadUserServiceList(String idUser) async {
    return listService = await ServiceDatabaseService().getUserServices(idUser);
  }

  Future<List<ServiceMessage>> loadMessagesServiceList(String idGroup) async {
    messageList =
        await MessageServiceDatabaseService().getServiceMessages(idGroup);
    notifyListeners();
    return messageList;
  }

  List<Service> get list {
    return listService;
  }

  List<ServiceMessage> get listMessage {
    return messageList;
  }
}

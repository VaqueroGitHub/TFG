import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/helpers/debouncer.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/models/service_message.dart';
import 'package:flutter_application_tfg/services/message_service_database_service.dart';
import 'package:flutter_application_tfg/services/service_database_service.dart';

class ServiceListProvider extends ChangeNotifier {
  List<Service> listService = [];
  List<ServiceMessage> messageList = [];

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Service>> _suggestionStreamContoller =
      new StreamController.broadcast();
  Stream<List<Service>> get suggestionStream =>
      this._suggestionStreamContoller.stream;

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

  void getSuggestionsByQueryCode(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results =
          await ServiceDatabaseService().getServicesByQueryCode(value);
      this._suggestionStreamContoller.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  List<Service> get list {
    return listService;
  }

  List<ServiceMessage> get listMessage {
    return messageList;
  }
}

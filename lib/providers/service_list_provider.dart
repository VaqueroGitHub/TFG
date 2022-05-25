import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/helpers/debouncer.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/models/service_message.dart';
import 'package:flutter_application_tfg/services/message_service_service.dart';
import 'package:flutter_application_tfg/services/service_service.dart';
import 'package:get_it/get_it.dart';

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
    return listService = await GetIt.I<ServiceService>().getAllServices();
  }

  Future<List<Service>> loadUserServiceList(String idUser) async {
    return listService =
        await GetIt.I<ServiceService>().getUserServices(idUser);
  }

  Future<List<ServiceMessage>> loadMessagesServiceList(String idGroup) async {
    messageList =
        await GetIt.I<MessageServiceService>().getServiceMessages(idGroup);
    notifyListeners();
    return messageList;
  }

  void getSuggestionsByQueryCode(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results =
          await GetIt.I<ServiceService>().getServicesByQueryCode(value);
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

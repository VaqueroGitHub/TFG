import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_tfg/models/service_message.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/repository/message_service_repository.dart';
import 'package:flutter_application_tfg/services/user_service.dart';
import 'package:get_it/get_it.dart';

class MessageServiceService {
  Future<Map<String, dynamic?>?> getMessage(String uuid) async {
    final resp = await GetIt.I<MessageServiceRepository>().getMessage(uuid);
    final data = resp.data();
    if (data == null) return null;
    final Map<String, dynamic?>? doc = data as Map<String, dynamic?>;
    return doc;
  }

  Future updateServiceMessage(
      ServiceMessage serviceMessage, String? uuid) async {
    if (uuid == null) {
      return await GetIt.I<MessageServiceRepository>().createServiceMessage({
        'message': serviceMessage.message,
        'idService': serviceMessage.idService,
        'idUser': serviceMessage.idUser,
        'datetime': serviceMessage.datetime,
      });
    }

    return await GetIt.I<MessageServiceRepository>().updateServiceMessage({
      'message': serviceMessage.message,
      'idService': serviceMessage.idService,
      'idUser': serviceMessage.idUser,
      'datetime': serviceMessage.datetime,
    }, uuid);
  }

  Future deleteServiceMessage(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference messageServiceCollection =
        FirebaseFirestore.instance.collection("MessageService");

    DocumentReference post = await messageServiceCollection.doc(uuid);
    await post.delete();
  }

  Future<List<ServiceMessage>> getServiceMessages(String idService) async {
    await Firebase.initializeApp();
    final QuerySnapshot messageServiceCollection = await FirebaseFirestore
        .instance
        .collection("MessageService")
        .where('idService', isEqualTo: idService)
        .orderBy("datetime", descending: true)
        .get();

    List<ServiceMessage> listMessages = [];
    for (var element in messageServiceCollection.docs) {
      Map<dynamic, dynamic> messageMap = element.data() as Map;
      User? user =
          await GetIt.I<UserService>().getUserData(messageMap['idUser']);
      ServiceMessage serviceMessage = ServiceMessage(
        message: messageMap['message'],
        idService: messageMap['idService'],
        idUser: messageMap['idUser'],
        user: user,
        id: element.id,
        datetime: messageMap['datetime'],
      );

      listMessages.add(serviceMessage);
    }

    return listMessages;
  }
}

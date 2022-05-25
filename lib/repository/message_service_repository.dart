import 'package:cloud_firestore/cloud_firestore.dart';

class MessageServiceRepository {
  final serviceReference =
      FirebaseFirestore.instance.collection("MessageService");

  Future<DocumentSnapshot> getMessage(String uuid) async {
    return await serviceReference.doc(uuid).get();
  }

  Future createServiceMessage(Map<String, Object> serviceMessage) async {
    return await serviceReference.add(serviceMessage);
  }

  Future updateServiceMessage(
      Map<String, Object> serviceMessage, String? uuid) async {
    return await serviceReference.doc(uuid).set(serviceMessage);
  }

  Future deleteServiceMessage(String uuid) async {
    return await serviceReference.doc(uuid).delete();
  }

  Future<QuerySnapshot> getServiceMessages(String idService) async {
    return await serviceReference
        .where('idService', isEqualTo: idService)
        .orderBy("datetime", descending: true)
        .get();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceRepository {
  final serviceReference = FirebaseFirestore.instance.collection("service");

  Future<DocumentSnapshot> getService(String uuid) async {
    return await serviceReference.doc(uuid).get();
  }

  Future createService(Map<String, Object> service) async {
    return await serviceReference.add(service);
  }

  Future updateService(Map<String, Object> service, String? uuid) async {
    return await serviceReference.doc(uuid).set(service);
  }

  Future deleteService(String uuid) async {
    return await serviceReference.doc(uuid).delete();
  }

  Future<QuerySnapshot> getUserOwnServices(String idUser) async {
    return await serviceReference.where('idOwnerUser', isEqualTo: idUser).get();
  }

  Future<QuerySnapshot> getUserJoinedServices(String idUser) async {
    return await serviceReference
        .where('idCustomerUser', isEqualTo: idUser)
        .get();
  }

  Future<QuerySnapshot> getAllServices() async {
    return await serviceReference.get();
  }

  Future<QuerySnapshot> getServicesByQueryCode(String query) async {
    return await serviceReference.where("code", isEqualTo: query).get();
  }
}

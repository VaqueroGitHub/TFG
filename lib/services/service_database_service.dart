import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/user_database_service.dart';

class ServiceDatabaseService {
  Future<Service?> getService(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference serviceCollection =
        FirebaseFirestore.instance.collection("service");

    final resp = await serviceCollection.doc(uuid).get();
    final data = resp.data() as Map<String, dynamic?>;
    if (data == null) return null;
    User? userOwner =
        await UserDatabaseService(uuid: data['idOwnerUser']).getUserData();
    User? userCustomer = !data['idCustomerUser'].toString().isEmpty
        ? await UserDatabaseService(uuid: data['idCustomerUser']).getUserData()
        : null;
    Service service = Service(
      code: data['code'],
      conference: data['conference'],
      description: data['description'],
      idOwnerUser: data['idOwnerUser'],
      idCustomerUser: data['idCustomerUser'],
      nCoins: data['nCoins'],
      id: resp.id,
      userOwner: userOwner,
      userCustomer: userCustomer,
    );

    return service;
  }

  Future updateService(Service service, String? uuid) async {
    await Firebase.initializeApp();
    final CollectionReference serviceCollection =
        FirebaseFirestore.instance.collection("service");

    if (uuid == null) {
      return await serviceCollection.add({
        "code": service.code,
        "conference": service.conference,
        "description": service.description,
        "idOwnerUser": service.idOwnerUser,
        "idCustomerUser": service.idCustomerUser,
        "nCoins": service.nCoins,
      });
    }
    return await serviceCollection.doc(uuid).set({
      "code": service.code,
      "conference": service.conference,
      "description": service.description,
      "idOwnerUser": service.idOwnerUser,
      "idCustomerUser": service.idCustomerUser,
      "nCoins": service.nCoins,
    });
  }

  Future deleteService(String uuid) async {
    await Firebase.initializeApp();
    final CollectionReference serviceCollection =
        FirebaseFirestore.instance.collection("service");

    DocumentReference post = await serviceCollection.doc(uuid);
    await post.delete();
  }

  Future obtainService(Service service, String idUser) async {
    await Firebase.initializeApp();
    final CollectionReference serviceCollection =
        FirebaseFirestore.instance.collection("service");

    if (service.idOwnerUser != idUser) service.idCustomerUser = idUser;

    return await serviceCollection.doc(service.id).set({
      "code": service.code,
      "conference": service.conference,
      "description": service.description,
      "idOwnerUser": service.idOwnerUser,
      "idCustomerUser": service.idCustomerUser,
      "nCoins": service.nCoins,
    });
  }

  Future<List<Service>> getUserServices(String idUser) async {
    await Firebase.initializeApp();
    final QuerySnapshot ownServiceCollection = await FirebaseFirestore.instance
        .collection("service")
        .where('idOwnerUser', isEqualTo: idUser)
        .get();
    final QuerySnapshot joinedServiceCollection = await FirebaseFirestore
        .instance
        .collection("service")
        .where('idCustomerUser', isEqualTo: idUser)
        .get();

    List<Service> listOwnServices = [];
    for (var element in ownServiceCollection.docs) {
      Map<dynamic, dynamic> serviceMap = element.data() as Map;
      User? userOwner =
          await UserDatabaseService(uuid: serviceMap['idOwnerUser'])
              .getUserData();
      User? userCustomer = !serviceMap['idCustomerUser'].toString().isEmpty
          ? await UserDatabaseService(uuid: serviceMap['idCustomerUser'])
              .getUserData()
          : null;
      Service service = Service(
        code: serviceMap['code'],
        conference: serviceMap['conference'],
        description: serviceMap['description'],
        idOwnerUser: serviceMap['idOwnerUser'],
        idCustomerUser: serviceMap['idCustomerUser'],
        nCoins: serviceMap['nCoins'],
        id: element.id,
        userOwner: userOwner,
        userCustomer: userCustomer,
      );

      listOwnServices.add(service);
    }

    List<Service> listJoinedServices = [];
    for (var element in joinedServiceCollection.docs) {
      Map<dynamic, dynamic> serviceMap = element.data() as Map;
      User? userOwner =
          await UserDatabaseService(uuid: serviceMap['idOwnerUser'])
              .getUserData();
      User? userCustomer = !serviceMap['idCustomerUser'].toString().isEmpty
          ? await UserDatabaseService(uuid: serviceMap['idCustomerUser'])
              .getUserData()
          : null;
      Service service = Service(
        code: serviceMap['code'],
        conference: serviceMap['conference'],
        description: serviceMap['description'],
        idOwnerUser: serviceMap['idOwnerUser'],
        idCustomerUser: serviceMap['idCustomerUser'],
        nCoins: serviceMap['nCoins'],
        id: element.id,
        userOwner: userOwner,
        userCustomer: userCustomer,
      );

      listJoinedServices.add(service);
    }

    List<Service> joinedList = List.from(listJoinedServices)
      ..addAll(listOwnServices);

    return joinedList;
  }

  Future<List<Service>> getAllServices() async {
    await Firebase.initializeApp();
    final QuerySnapshot serviceCollection =
        await FirebaseFirestore.instance.collection("service").get();

    List<Service> listOwnServices = [];
    for (var element in serviceCollection.docs) {
      Map<dynamic, dynamic> serviceMap = element.data() as Map;
      User? userOwner =
          await UserDatabaseService(uuid: serviceMap['idOwnerUser'])
              .getUserData();
      User? userCustomer = !serviceMap['idCustomerUser'].toString().isEmpty
          ? await UserDatabaseService(uuid: serviceMap['idCustomerUser'])
              .getUserData()
          : null;
      Service service = Service(
        code: serviceMap['code'],
        conference: serviceMap['conference'],
        description: serviceMap['description'],
        idOwnerUser: serviceMap['idOwnerUser'],
        idCustomerUser: serviceMap['idCustomerUser'],
        nCoins: serviceMap['nCoins'],
        id: element.id,
        userOwner: userOwner,
        userCustomer: userCustomer,
      );

      listOwnServices.add(service);
    }

    return listOwnServices;
  }

  Future<List<Service>> getServicesByQueryCode(String query) async {
    await Firebase.initializeApp();
    final QuerySnapshot serviceCollection = await FirebaseFirestore.instance
        .collection("service")
        .where("code", isEqualTo: query)
        .get();

    List<Service> listQueryServices = [];
    for (var element in serviceCollection.docs) {
      Map<dynamic, dynamic> serviceMap = element.data() as Map;
      User? userOwner =
          await UserDatabaseService(uuid: serviceMap['idOwnerUser'])
              .getUserData();
      User? userCustomer = !serviceMap['idCustomerUser'].toString().isEmpty
          ? await UserDatabaseService(uuid: serviceMap['idCustomerUser'])
              .getUserData()
          : null;
      Service service = Service(
        code: serviceMap['code'],
        conference: serviceMap['conference'],
        description: serviceMap['description'],
        idOwnerUser: serviceMap['idOwnerUser'],
        idCustomerUser: serviceMap['idCustomerUser'],
        nCoins: serviceMap['nCoins'],
        id: element.id,
        userOwner: userOwner,
        userCustomer: userCustomer,
      );

      listQueryServices.add(service);
    }

    return listQueryServices;
  }
}

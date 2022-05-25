import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/repository/service_repository.dart';
import 'package:flutter_application_tfg/services/user_service.dart';
import 'package:get_it/get_it.dart';

class ServiceService {
  Future<Service?> getService(String uuid) async {
    final resp = await GetIt.I<ServiceRepository>().getService(uuid);
    final data = resp.data() as Map<String, dynamic?>;
    if (data == null) return null;
    User? userOwner =
        await GetIt.I<UserService>().getUserData(data['idOwnerUser']);
    User? userCustomer = !data['idCustomerUser'].toString().isEmpty
        ? await GetIt.I<UserService>().getUserData(data['idCustomerUser'])
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
    if (uuid == null) {
      return await GetIt.I<ServiceRepository>().createService({
        "code": service.code,
        "conference": service.conference,
        "description": service.description,
        "idOwnerUser": service.idOwnerUser,
        "idCustomerUser": service.idCustomerUser,
        "nCoins": service.nCoins,
      });
    }
    return await GetIt.I<ServiceRepository>().updateService({
      "code": service.code,
      "conference": service.conference,
      "description": service.description,
      "idOwnerUser": service.idOwnerUser,
      "idCustomerUser": service.idCustomerUser,
      "nCoins": service.nCoins,
    }, uuid);
  }

  Future deleteService(String uuid) async {
    return GetIt.I<ServiceRepository>().deleteService(uuid);
  }

  Future obtainService(Service service, String idUser) async {
    if (service.idOwnerUser != idUser) service.idCustomerUser = idUser;

    return await GetIt.I<ServiceRepository>().updateService({
      "code": service.code,
      "conference": service.conference,
      "description": service.description,
      "idOwnerUser": service.idOwnerUser,
      "idCustomerUser": service.idCustomerUser,
      "nCoins": service.nCoins,
    }, service.id);
  }

  Future<List<Service>> getUserServices(String idUser) async {
    final QuerySnapshot ownServiceCollection =
        await GetIt.I<ServiceRepository>().getUserOwnServices(idUser);
    final QuerySnapshot joinedServiceCollection =
        await GetIt.I<ServiceRepository>().getUserJoinedServices(idUser);

    List<Service> listOwnServices = [];
    for (var element in ownServiceCollection.docs) {
      Map<dynamic, dynamic> serviceMap = element.data() as Map;
      User? userOwner =
          await GetIt.I<UserService>().getUserData(serviceMap['idOwnerUser']);
      User? userCustomer = !serviceMap['idCustomerUser'].toString().isEmpty
          ? await GetIt.I<UserService>()
              .getUserData(serviceMap['idCustomerUser'])
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
          await GetIt.I<UserService>().getUserData(serviceMap['idOwnerUser']);
      User? userCustomer = !serviceMap['idCustomerUser'].toString().isEmpty
          ? await GetIt.I<UserService>()
              .getUserData(serviceMap['idCustomerUser'])
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
    List<Service> listOwnServices = [];
    for (var element
        in (await GetIt.I<ServiceRepository>().getAllServices()).docs) {
      Map<dynamic, dynamic> serviceMap = element.data() as Map;
      User? userOwner =
          await GetIt.I<UserService>().getUserData(serviceMap['idOwnerUser']);
      User? userCustomer = !serviceMap['idCustomerUser'].toString().isEmpty
          ? await GetIt.I<UserService>()
              .getUserData(serviceMap['idCustomerUser'])
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
    final QuerySnapshot serviceCollection =
        await GetIt.I<ServiceRepository>().getServicesByQueryCode(query);

    List<Service> listQueryServices = [];
    for (var element in serviceCollection.docs) {
      Map<dynamic, dynamic> serviceMap = element.data() as Map;
      User? userOwner =
          await GetIt.I<UserService>().getUserData(serviceMap['idOwnerUser']);
      User? userCustomer = !serviceMap['idCustomerUser'].toString().isEmpty
          ? await GetIt.I<UserService>()
              .getUserData(serviceMap['idCustomerUser'])
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

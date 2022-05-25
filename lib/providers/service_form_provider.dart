import 'package:flutter/widgets.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/services/user_service.dart';
import 'package:get_it/get_it.dart';

class ServiceFormProvider extends ChangeNotifier {
  String code = '';
  String conference = '';
  String description = '';
  String idOwnerUser = '';
  String idCustomerUser = '';
  int nCoins = -1;
  String? id;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<Service> service() async {
    return Service(
        code: code,
        conference: conference,
        description: description,
        idOwnerUser: idOwnerUser,
        idCustomerUser: idCustomerUser,
        userCustomer: idCustomerUser != null && idCustomerUser.isEmpty == false
            ? await GetIt.I<UserService>().getUserData(idCustomerUser)
            : null,
        userOwner: await GetIt.I<UserService>().getUserData(idOwnerUser),
        nCoins: nCoins,
        id: id);
  }

  void setService(Service service) {
    code = service.code;
    conference = service.conference;
    description = service.description;
    idOwnerUser = service.idOwnerUser;
    idCustomerUser = service.idCustomerUser;
    nCoins = service.nCoins;
    id = service.id;
  }

  void setEmptyService() {
    code = '';
    conference = '';
    description = '';
    idOwnerUser = '';
    idCustomerUser = '';
    nCoins = -1;
    id = null;
  }
}

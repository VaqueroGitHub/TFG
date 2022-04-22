import 'package:flutter/widgets.dart';
import 'package:flutter_application_tfg/models/service.dart';

class ServiceFormProvider extends ChangeNotifier {
  String code = '';
  String conference = '';
  String description = '';
  String idOwnerUser = '';
  String idCustomerUser = '';
  int nCoins = -1;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Service service(userSessionProvider) {
    return Service(
        code: code,
        conference: conference,
        description: description,
        idOwnerUser: idOwnerUser,
        idCustomerUser: idCustomerUser,
        nCoins: nCoins);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/service_form_provider.dart';
import 'package:flutter_application_tfg/services/service_database_service.dart';
import 'package:provider/provider.dart';
import '../../providers/user_session_provider.dart';

class NewServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context)),
        ),
        backgroundColor: Color(0xFFffffff),
        body: _NewGroupPage(height: height));
  }
}

class _NewGroupPage extends StatelessWidget {
  const _NewGroupPage({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    final serviceFormProvider = Provider.of<ServiceFormProvider>(context);

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  Text(
                    '¡Publica tu nuevo servicio a compartir! 🤝🏻',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    'Rellena los datos del servicio 📝',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => serviceFormProvider.code = val,
                    decoration: const InputDecoration(
                        labelText:
                            "Introduce el codigo del Servicio(max 3 chars)"),
                    minLines: 1,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => val != ''
                        ? serviceFormProvider.nCoins = int.parse(val)
                        : serviceFormProvider.nCoins = -1,
                    decoration: const InputDecoration(
                        labelText: "Introduce el coste del servicio"),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => serviceFormProvider.conference = val,
                    decoration: const InputDecoration(
                        labelText:
                            "Introduce la posible url para la conferencia online a dar el servicio "),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (val) => serviceFormProvider.description = val,
                    decoration: const InputDecoration(
                        labelText:
                            "Describe detalladamente el servicio a prestar"),
                  ),
                  SizedBox(height: height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        elevation: 10.0,
                        minWidth: 170.0,
                        height: 50.0,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Text(
                          'Publicar servicio',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          if (serviceFormProvider.code != '' &&
                              serviceFormProvider.description != '' &&
                              serviceFormProvider.nCoins != -1) {
                            serviceFormProvider.idOwnerUser =
                                userSessionProvider.user.id!;
                            ServiceDatabaseService().updateService(
                                serviceFormProvider
                                    .service(userSessionProvider),
                                null);
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                'servicesMainPage',
                                (Route<dynamic> route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("RELLENA TODOS LOS CAMPOS")));
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

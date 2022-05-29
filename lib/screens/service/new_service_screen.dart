import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/service_details_provider.dart';
import 'package:flutter_application_tfg/providers/service_form_provider.dart';
import 'package:flutter_application_tfg/providers/service_list_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/service_arguments.dart';
import 'package:flutter_application_tfg/services/service_service.dart';
import 'package:get_it/get_it.dart';
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
        body: _NewServiceBody(height: height));
  }
}

class _NewServiceBody extends StatelessWidget {
  const _NewServiceBody({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    final serviceFormProvider = Provider.of<ServiceFormProvider>(context);
    final serviceDetailsProvider = Provider.of<ServiceDetailsProvider>(context);
    final serviceListProvider = Provider.of<ServiceListProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as ServiceArguments;

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Form(
              key: serviceFormProvider.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  !args.isEditing
                      ? Text(
                          '¡Publica tu nuevo servicio a compartir! 🤝🏻',
                          style: Theme.of(context).textTheme.headline2,
                        )
                      : Container(),
                  Text(
                    'Rellena los datos del servicio 📝',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    initialValue: serviceFormProvider.code,
                    onChanged: (val) => serviceFormProvider.code = val,
                    validator: (val) {
                      return (val == null || val.isEmpty || val.length > 3)
                          ? 'Introduzca un codigo de servicio válido'
                          : null;
                    },
                    maxLength: 3,
                    decoration: const InputDecoration(
                        labelText: "Introduce el codigo del Servicio"),
                    minLines: 1,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    initialValue: serviceFormProvider.conference,
                    onChanged: (val) => serviceFormProvider.conference = val,
                    validator: (val) {
                      return (val == null ||
                              val.isEmpty ||
                              !val.startsWith('https://www.zoom.us/'))
                          ? 'Escriba una conferencia zoom valida: https://www.zoom.us/...'
                          : null;
                    },
                    decoration: const InputDecoration(
                        labelText:
                            "Introduce la posible url para la conferencia online a dar el servicio "),
                    keyboardType: TextInputType.url,
                    maxLines: null,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    initialValue: serviceFormProvider.description,
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 500,
                    onChanged: (val) => serviceFormProvider.description = val,
                    validator: (val) {
                      return (val == null ||
                              val.length < 10 ||
                              val.length > 500)
                          ? 'Escriba una descripción entre 10 y 500 caracteres.'
                          : null;
                    },
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
                        child: Text(
                          args.isEditing
                              ? 'Editar servicio'
                              : 'Publicar servicio',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          if (!serviceFormProvider.isValidForm()) return;
                          serviceFormProvider.idOwnerUser.isEmpty
                              ? (serviceFormProvider.idOwnerUser =
                                  userSessionProvider.user.id!)
                              : null;
                          await GetIt.I<ServiceService>().updateService(
                              await serviceFormProvider.service(),
                              args.isEditing ? args.service!.id : null);
                          await serviceListProvider.loadUserServiceList(
                              userSessionProvider.user.id!);
                          serviceListProvider.notifyListeners();
                          if (args.isEditing) {
                            serviceDetailsProvider.service =
                                await serviceFormProvider.service();

                            Navigator.pop(
                                context, serviceFormProvider.service());
                          } else
                            Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

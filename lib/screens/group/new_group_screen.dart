import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/group_form_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_tfg/services/group_database_service.dart';

import '../../providers/user_session_provider.dart';

class NewGroupPage extends StatelessWidget {
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
    final groupFormProvider = Provider.of<GroupFormProvider>(context);

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  Text(
                    '¡Crea tu nuevo grupo de estudio! 🤝🏻',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    'Rellena los datos del grupo 📝',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => groupFormProvider.asignatura = val,
                    decoration: const InputDecoration(
                        labelText: "Introduce el codigo de la asignatura"),
                    minLines: 1,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => val != ''
                        ? groupFormProvider.nMembersRequired = int.parse(val)
                        : groupFormProvider.nMembersRequired = -1,
                    decoration: const InputDecoration(
                        labelText: "Introduce el tamaño del grupo"),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => val != ''
                        ? groupFormProvider.year = int.parse(val)
                        : groupFormProvider.year = -1,
                    decoration: const InputDecoration(
                        labelText:
                            "Introduce el curso al que pertenece la asignatura"),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => groupFormProvider.githUrl = val,
                    decoration: const InputDecoration(
                        labelText:
                            "Introduce la url del repositorio github del grupo"),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => groupFormProvider.driveUrl = val,
                    decoration: const InputDecoration(
                        labelText:
                            "Introduce la url del repositorio drive del grupo"),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (val) => groupFormProvider.description = val,
                    decoration: const InputDecoration(
                        labelText: "¿Qué esperas de los miembros del grupo?"),
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
                          'Crear grupo',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          if (groupFormProvider.asignatura != '' &&
                              groupFormProvider.description != '' &&
                              groupFormProvider.year != -1 &&
                              groupFormProvider.nMembersRequired != -1) {
                            GroupDatabaseService().updateGroup(
                                groupFormProvider.group(userSessionProvider),
                                null);
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                'groupsMainPage',
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

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/group.dart';
import 'package:flutter_application_tfg/providers/user_register_provider.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
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
          elevation: 0,
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

    //creo un objeto grupo
    Group grupo = new Group(
        asignatura: '',
        year: -1,
        description: '',
        nMembersRequired: -1,
        idMembers: [userSessionProvider.user.id!],
        idUser: userSessionProvider.user.id!);

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
                    onChanged: (val) => grupo.asignatura = val,
                    decoration: const InputDecoration(
                        labelText: "Introduce el codigo de la asignatura"),
                    minLines: 1,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => val != ''
                        ? grupo.nMembersRequired = int.parse(val)
                        : grupo.nMembersRequired = -1,
                    decoration: const InputDecoration(
                        labelText: "Introduce el tamaño del grupo"),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => val != ''
                        ? grupo.year = int.parse(val)
                        : grupo.year = -1,
                    decoration: const InputDecoration(
                        labelText:
                            "Introduce el curso al que pertenece la asignatura"),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (val) => grupo.description = val,
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
                          if (grupo.asignatura != '' &&
                              grupo.description != '' &&
                              grupo.year != -1 &&
                              grupo.nMembersRequired != -1) {
                            GroupDatabaseService().updateGroup(grupo, null);
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

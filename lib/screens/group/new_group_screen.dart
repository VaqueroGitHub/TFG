import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/group_form_provider.dart';
import 'package:flutter_application_tfg/providers/group_list_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/group_arguments.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_tfg/services/group_service.dart';

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
    final args = ModalRoute.of(context)!.settings.arguments as GroupArguments;

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Form(
              key: groupFormProvider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  !args.isEditing
                      ? Text(
                          '¡Crea tu nuevo grupo de estudio! 🤝🏻',
                          style: Theme.of(context).textTheme.headline2,
                        )
                      : Container(),
                  Text(
                    'Rellena los datos del grupo 📝',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    initialValue: groupFormProvider.asignatura,
                    onChanged: (val) => groupFormProvider.asignatura = val,
                    decoration: const InputDecoration(
                        labelText: "Introduce el codigo de la asignatura"),
                    minLines: 1,
                    maxLength: 3,
                    validator: (val) {
                      return val == null || val.isEmpty
                          ? 'Codigo de asignatura obligatorio'
                          : (val.length < 0 || val.length > 3
                              ? 'Codigo deber ser entre al menos 1 y 3 caracteres'
                              : null);
                    },
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: groupFormProvider.nMembersRequired > 0
                        ? groupFormProvider.nMembersRequired.toString()
                        : '',
                    onChanged: (val) => val != ''
                        ? groupFormProvider.nMembersRequired = int.parse(val)
                        : groupFormProvider.nMembersRequired = -1,
                    decoration: const InputDecoration(
                        labelText: "Introduce el tamaño del grupo"),
                    validator: (val) {
                      return val == null ||
                              val.isEmpty ||
                              int.tryParse(val) == null
                          ? 'Tamaño grupo obligatorio'
                          : (int.parse(val) < 2
                              ? 'Tamaño grupo deber ser al menos de 2 personas'
                              : null);
                    },
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    initialValue: groupFormProvider.year > 0
                        ? groupFormProvider.year.toString()
                        : '',
                    onChanged: (val) => val != ''
                        ? groupFormProvider.year = int.parse(val)
                        : groupFormProvider.year = -1,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText:
                            "Introduce el año del curso al que pertenece la asignatura"),
                    validator: (val) {
                      return val == null ||
                              val.isEmpty ||
                              int.tryParse(val) == null
                          ? 'Año del curso obligatorio'
                          : (int.parse(val) < 1
                              ? 'Año del curso deber estar entre el 1 y el 4'
                              : null);
                    },
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    keyboardType: TextInputType.url,
                    initialValue: groupFormProvider.githUrl,
                    onChanged: (val) => groupFormProvider.githUrl = val,
                    decoration: const InputDecoration(
                        labelText:
                            "Introduce la url del repositorio github del grupo"),
                    validator: (val) {
                      return val != null &&
                              !val.isEmpty &&
                              !val.startsWith('https://www.github.com/')
                          ? 'La url debe empezar por https://www.github.com/'
                          : null;
                    },
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    keyboardType: TextInputType.url,
                    initialValue: groupFormProvider.driveUrl,
                    onChanged: (val) => groupFormProvider.driveUrl = val,
                    decoration: const InputDecoration(
                        labelText:
                            "Introduce la url del repositorio drive del grupo"),
                    validator: (val) {
                      return val != null &&
                              !val.isEmpty &&
                              !val.startsWith('https://drive.google.com/')
                          ? 'La url debe empezar por https://drive.google.com/'
                          : null;
                    },
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    // any number you need (It works as the rows for the textarea)
                    initialValue: groupFormProvider.description,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (val) => groupFormProvider.description = val,
                    decoration: const InputDecoration(
                        labelText: "¿Qué esperas de los miembros del grupo?"),
                    maxLength: 500,
                    validator: (val) {
                      return val == null || val.isEmpty
                          ? 'Descripción del grupo obligatoria'
                          : (val.length < 10
                              ? 'Descripción debe ser de al menos 10 caracteres'
                              : null);
                    },
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
                          args.isEditing ? 'Editar grupo' : 'Crear grupo',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          if (!groupFormProvider.isValidForm()) return;

                          await GetIt.I<GroupService>().updateGroup(
                              groupFormProvider.group(userSessionProvider),
                              args.isEditing ? args.group!.id : null);
                          final groupListProvider =
                              Provider.of<GroupListProvider>(context,
                                  listen: false);
                          await groupListProvider
                              .loadUserGroupList(userSessionProvider.user.id!);
                          groupListProvider.notifyListeners();
                          Navigator.pop(
                              context,
                              args.isEditing
                                  ? await GetIt.I<GroupService>()
                                      .getGroup(args.group!.id!)
                                  : null);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

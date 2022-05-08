import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/edit_user_provider.dart';
import 'package:flutter_application_tfg/providers/email_pass_form_provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_application_tfg/services/user_database_service.dart';
import 'package:flutter_application_tfg/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? localImage = null;

  @override
  Widget build(BuildContext context) {
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    final editUserProvider = Provider.of<EditUserProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFffffff),
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
      body: Form(
        key: editUserProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: Text(
                'Modifica tus datos,' + args.user.nick,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SizedBox(height: height * 0.02),
            ProfileWidget(
              fileImage: localImage == null ? args.user.url : localImage,
              isEdit: true,
              onClicked: () async {
                final picker = new ImagePicker();
                final PickedFile? pickedFile = await picker.getImage(
                    // source: ImageSource.gallery,
                    source: ImageSource.camera,
                    imageQuality: 100);

                if (pickedFile == null) {
                  return;
                }
                editUserProvider.newPictureFile =
                    File.fromUri(Uri(path: pickedFile.path));
                String? newPictureLocal = await editUserProvider.uploadImage();

                setState(() {
                  localImage = newPictureLocal;
                });
              },
            ),
            TextFormField(
              initialValue: editUserProvider.user.fullName,
              onChanged: (val) => editUserProvider.user.fullName = val,
              decoration: const InputDecoration(labelText: "Nombre completo"),
              minLines: 1,
            ),
            SizedBox(height: height * 0.05),
            TextFormField(
              initialValue: editUserProvider.user.nick,
              onChanged: (val) => editUserProvider.user.nick = val,
              decoration: const InputDecoration(labelText: "Nick"),
              validator: (val) {
                if (val == null || val.length < 1)
                  return 'Nick no puede ser vacío.';
              },
            ),
            SizedBox(height: height * 0.05),
            TextFormField(
              initialValue: editUserProvider.user.bio,
              onChanged: (val) => editUserProvider.user.bio = val,
              decoration: const InputDecoration(labelText: "Bio"),
              minLines: 1,
              maxLines: 6,
            ),
            SizedBox(height: height * 0.07),
            editUserProvider.user.id != userSessionProvider.user.id
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          elevation: 10.0,
                          minWidth: 170.0,
                          height: 50.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.indigo, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text(
                            'Cambiar email/password',
                            style:
                                TextStyle(color: Colors.indigo, fontSize: 20.0),
                          ),
                          onPressed: () {
                            _ChangeEmailPassword(context, userSessionProvider);
                          }),
                      SizedBox(height: height * 0.07),
                    ],
                  ),
            SizedBox(height: height * 0.03),
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
                    'Guardar cambios',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () {
                    if (!editUserProvider.isValidForm()) return;
                    if (localImage != null) {
                      args.user.url = localImage;
                      if (args.userSession) {
                        setState(() {
                          userSessionProvider.user.url = localImage;
                        });
                      }
                    }
                    UserDatabaseService(uuid: args.id)
                        .updateUserData(args.user, true);
                    if (args.userSession) {
                      // userSessionProvider.user.url = editUserProvider.imageL;
                      Navigator.pop(context); // pop current page
                    } else {
                      Navigator.pushNamedAndRemoveUntil(context,
                          'adminHomePage', (Route<dynamic> route) => false,
                          arguments: 0);
                    }
                  },
                ),
                SizedBox(height: height * 0.07),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _ChangeEmailPassword(
      BuildContext context, UserSessionProvider userSessionProvider) {
    final emailPassFormProvider =
        Provider.of<EmailPassFormProvider>(context, listen: false);
    emailPassFormProvider.email = userSessionProvider.user.email;
    emailPassFormProvider.password = userSessionProvider.user.password;
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Cambiar email/password'),
            content: Container(
              height: 270.0,
              child: Form(
                key: emailPassFormProvider.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: emailPassFormProvider.email,
                      onChanged: (val) => emailPassFormProvider.email = val,
                      validator: (val) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(pattern);
                        return regExp.hasMatch(val ?? '')
                            ? null
                            : 'Escriba un email valido';
                      },
                      decoration: const InputDecoration(labelText: "Email"),
                      minLines: 1,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: emailPassFormProvider.password,
                      onChanged: (val) => emailPassFormProvider.password = val,
                      decoration: const InputDecoration(labelText: "Password"),
                      validator: (val) {
                        if (val == null || val.length < 6)
                          return 'La contraseña debe tener al menos 6 caracteres';
                      },
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      initialValue: emailPassFormProvider.password,
                      onChanged: (val) =>
                          emailPassFormProvider.confirmPassword = val,
                      validator: (val) {
                        if (val != emailPassFormProvider.password)
                          return 'Las contraseñas no coinciden';
                      },
                      decoration:
                          const InputDecoration(labelText: "Confirm password"),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () async {
                    if (!emailPassFormProvider.isValidForm()) return;

                    // Close the dialog
                    Navigator.of(context).pop();

                    String? resp = await AuthService().changeEmailPassword(
                        emailPassFormProvider, userSessionProvider);

                    print(resp);
                    if (resp != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("ERROR: $resp")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "EXITO: Volver hacer login para aplicar cambios")));
                    }
                  },
                  child: const Text('CONFIRMAR')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('CANCELAR'))
            ],
          );
        });
  }
}

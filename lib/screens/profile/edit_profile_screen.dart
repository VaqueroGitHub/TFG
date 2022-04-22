import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/edit_user_provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
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
    //localImage = args.user.url;
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
              fileImage: localImage,
              isEdit: true,
              onClicked: () async {
                final picker = new ImagePicker();
                final PickedFile? pickedFile = await picker.getImage(
                    // source: ImageSource.gallery,
                    source: ImageSource.camera,
                    imageQuality: 100);

                if (pickedFile == null) {
                  print('No seleccionó nada');
                  return;
                }
                editUserProvider.newPictureFile =
                    File.fromUri(Uri(path: pickedFile.path));
                String? newPictureLocal = await editUserProvider.uploadImage();

                setState(() {
                  localImage = newPictureLocal;
                });
                // editUserProvider.imageL = newPictureLocal;
                // editUserProvider.notifyListeners();
              },
            ),
            TextFormField(
              initialValue: args.user.fullName,
              onChanged: (val) => args.user.fullName = val,
              decoration: const InputDecoration(labelText: "Nombre completo"),
              minLines: 1,
            ),
            SizedBox(height: height * 0.05),
            TextFormField(
              initialValue: args.user.nick,
              onChanged: (val) => args.user.nick = val,
              decoration: const InputDecoration(labelText: "Nick"),
            ),
            SizedBox(height: height * 0.05),
            TextFormField(
              initialValue: args.user.bio,
              onChanged: (val) => args.user.bio = val,
              decoration: const InputDecoration(labelText: "Bio"),
              minLines: 1,
              maxLines: 6,
            ),
            SizedBox(height: height * 0.07),
            args.user.id != userSessionProvider.user.id
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
                            openDialog(context, args);
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
                    if (localImage != null) args.user.url = localImage;
                    UserDatabaseService(uuid: args.id)
                        .updateUserData(args.user);
                    if (args.userSession) {
                      setState(() {
                        userSessionProvider.user.url = localImage;
                      });
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

  Widget getImage(File? picture) {
    if (picture == null)
      return Image(
        image: AssetImage('assets/imgs/no-image.png'),
        fit: BoxFit.contain,
        width: 128,
        height: 128,
      );

    if (picture.path.startsWith('http'))
      return FadeInImage(
        image: NetworkImage(picture.path),
        placeholder: AssetImage('assets/imgs/jar-loading.png'),
        fit: BoxFit.contain,
        width: 128,
        height: 128,
      );

    return Image.file(
      File(picture.path),
      fit: BoxFit.contain,
      width: 128,
      height: 128,
    );
  }

  Future openDialog(context, args) => showDialog(
      context: context, builder: (_) => _EmailPasswordDialog(args: args));
}

class _EmailPasswordDialog extends StatelessWidget {
  final args;
  const _EmailPasswordDialog({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nuevos Datos autenticacion'),
      content: Form(
          child: Column(
        children: [
          TextFormField(
            initialValue: args.user.email,
            onChanged: (val) => args.user.email = val,
            decoration: const InputDecoration(labelText: "Email"),
            minLines: 1,
          ),
          SizedBox(height: 20),
          TextFormField(
            initialValue: args.user.password,
            onChanged: (val) => args.user.password = val,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
        ],
      )),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('Confirmar'))
      ],
    );
  }
}

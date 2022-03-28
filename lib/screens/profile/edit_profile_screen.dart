import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:flutter_application_tfg/services/user_database_service.dart';
import 'package:flutter_application_tfg/widgets/widgets.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final userSessionProvider = Provider.of<UserSessionProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;

    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              imagePath:
                  'https://www.freeiconspng.com/thumbs/profile-icon-png/profile-icon-9.png',
              isEdit: true,
              onClicked: () async {},
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
            // SizedBox(height: height * 0.05),
            // TextFormField(
            //   initialValue: args.user.email,
            //   onChanged: (val) => args.user.email = val,
            //   decoration:
            //       const InputDecoration(labelText: "Correo universitario"),
            // ),
            // SizedBox(height: height * 0.05),
            // TextFormField(
            //   initialValue: args.user.password,
            //   onChanged: (val) => args.user.password = val,
            //   decoration: const InputDecoration(labelText: "Contraseña"),
            //   obscureText: true,
            // ),
            SizedBox(height: height * 0.05),
            TextFormField(
              initialValue: args.user.bio,
              onChanged: (val) => args.user.bio = val,
              decoration: const InputDecoration(labelText: "Bio"),
              minLines: 1,
              maxLines: 6,
            ),
            SizedBox(height: height * 0.07),
            Row(
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
                    style: TextStyle(color: Colors.indigo, fontSize: 20.0),
                  ),
                  onPressed: () {},
                ),
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
                    UserDatabaseService(uuid: 'asd').updateUserData(args.user);
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'profile', (Route<dynamic> route) => false);
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
}

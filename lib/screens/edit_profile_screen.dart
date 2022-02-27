// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_application_tfg/services/user_database_service.dart';
import 'package:flutter_application_tfg/styles/tfg_theme.dart';
import 'package:flutter_application_tfg/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfilePage extends StatelessWidget {
  User user = User(
    'Joaquin',
    'Joaquin Asensio Manzanas',
    'joasexi@gmail.com',
    'joasexi',
    true,
  );
  //User user = UserDatabaseService.getUserData();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          Center(
            child: Text(
              'Modifica tus datos',
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
          SizedBox(height: height * 0.05),
          TextFormField(
            initialValue: user.fullName,
            onChanged: (val) => user.fullName = val,
            decoration: const InputDecoration(labelText: "Nombre completo"),
            minLines: 1,
          ),
          SizedBox(height: height * 0.05),
          TextFormField(
            initialValue: user.nick,
            onChanged: (val) => user.nick = val,
            decoration: const InputDecoration(labelText: "Nick"),
          ),
          SizedBox(height: height * 0.05),
          TextFormField(
            initialValue: user.email,
            onChanged: (val) => user.email = val,
            decoration:
                const InputDecoration(labelText: "Correo universitario"),
          ),
          SizedBox(height: height * 0.05),
          TextFormField(
            initialValue: user.password,
            onChanged: (val) => user.password = val,
            decoration: const InputDecoration(labelText: "Contraseña"),
            obscureText: true,
          ),
          SizedBox(height: height * 0.07),
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'profile', (Route<dynamic> route) => false);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

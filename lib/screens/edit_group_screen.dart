// ignore_for_file: file_names
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_application_tfg/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EditGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userSessionProvider = Provider.of<UserSessionProvider>(context);

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
              'Modifica tu grupo',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          SizedBox(height: height * 0.02),
          SizedBox(height: height * 0.05),
          TextFormField(
            initialValue: userSessionProvider.user.fullName,
            onChanged: (val) => userSessionProvider.user.fullName = val,
            decoration: const InputDecoration(labelText: "Codigo asignatura"),
            minLines: 1,
          ),
          SizedBox(height: height * 0.05),
          TextFormField(
            initialValue: userSessionProvider.user.nick,
            onChanged: (val) => userSessionProvider.user.nick = val,
            decoration: const InputDecoration(labelText: "Tamaño del grupo"),
          ),
          SizedBox(height: height * 0.05),
          TextFormField(
            initialValue: userSessionProvider.user.email,
            onChanged: (val) => userSessionProvider.user.email = val,
            decoration: const InputDecoration(labelText: "Curso"),
          ),
          SizedBox(height: height * 0.05),
          TextFormField(
            initialValue: userSessionProvider.user.password,
            onChanged: (val) => userSessionProvider.user.password = val,
            decoration: const InputDecoration(
                labelText: "¿Qué esperas de los miembros del grupo?"),
            obscureText: true,
          ),
          SizedBox(height: height * 0.07),
          Text(
            'Miembros',
            style: Theme.of(context).textTheme.headline4,
          ),
          Column(children: [_buildListView(context)]),
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

ListView _buildListView(BuildContext context) {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (_, index) {
      return ListTile(
        title: Text('Carlos Luengo Peras'),
        subtitle: Text('carluenagitano@ucm.es'),
        trailing: Wrap(
          spacing: 12, // space between two icons
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Navigator.pushNamed(context, 'editProfile');
              },
            )
          ],
        ),
      );
    },
  );
}

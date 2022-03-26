// ignore_for_file: file_names

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_application_tfg/widgets/widgets.dart';

class GroupDetailsScreen extends StatefulWidget {
  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreen();
}

class _GroupDetailsScreen extends State<GroupDetailsScreen> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = User(
        fullName: 'hola',
        password: 'ee',
        isAdmin: true,
        email: 'pepe',
        nick: 'papo');
  }

  void setUser(user) {
    setState(() {
      this.user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    //User user = User(
    //    nick: 'Joaquin',
    //    fullName: 'Joaquin Asensio Manzanas',
    //    email: 'joasexi@gmail.com',
    //    password: 'joasexi',
    //    isAdmin: true);
    AuthService().getUser().then((value) => setUser(value));
    return Builder(
      builder: (context) => Scaffold(
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 40),
            Center(
              child: Text(
                'Grupos',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            const SizedBox(height: 24),
            GroupNumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(context, user),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  elevation: 10.0,
                  minWidth: 200.0,
                  height: 50.0,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Únete',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () async {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildName(BuildContext context, User user) => Column(
        children: [
          Text(
            user.nick,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(BuildContext context, User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¿Qué busca el grupo? 👨🏻‍🎓',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 16),
            Text(
              'Buscamos gente competente que este dispuesta a trabajar 2 horas a la semana. Preferiblemente martes y jueves y que tenga conocimientos de Inteligencia Artificial',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      );
}

class GroupNumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '2/6', 'Miembros'),
          buildDivider(),
          buildButton(context, 'AW', 'Asignatura'),
          buildDivider(),
          buildButton(context, 'Joasensi', 'Propietario'),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}

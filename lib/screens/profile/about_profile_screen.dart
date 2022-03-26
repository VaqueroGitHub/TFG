// ignore_for_file: file_names

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_application_tfg/widgets/widgets.dart';

class AboutProfilePage extends StatefulWidget {
  @override
  State<AboutProfilePage> createState() => _AboutProfilePageState();
}

class _AboutProfilePageState extends State<AboutProfilePage> {
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
            ProfileWidget(
              imagePath:
                  'https://www.freeiconspng.com/thumbs/profile-icon-png/profile-icon-9.png',
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            buildName(context, user),
            const SizedBox(height: 24),
            NumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(context, user),
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
              'Sobre mi 👨🏻‍🎓',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 16),
            Text(
              'Cuenta de ' +
                  user.fullName +
                  ', estudiante del grado de Ingeniería del Software de la Universidad Complutense.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      );
}

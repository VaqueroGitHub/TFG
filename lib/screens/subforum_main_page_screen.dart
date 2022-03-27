// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_application_tfg/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubforumMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              'General',
              style: Theme.of(context).textTheme.headline3,
            ),
            _GroupButtons(),
            SizedBox(height: 10),
            _GroupLabel(
              etiqueta: 'Quiero aprobar MDL',
              text: "",
              press: () => {Navigator.pushNamed(context, 'postMainPage')},
            ),
            SizedBox(height: 10),
            _GroupLabel(
              etiqueta: '¿Alguien sabe el correo de N...',
              text: "",
              press: () => {Navigator.pushNamed(context, 'postMainPage')},
            ),
            SizedBox(height: 10),
            _GroupLabel(
              etiqueta: 'Ideas para la semana de la in...',
              text: "",
              press: () => {Navigator.pushNamed(context, 'postMainPage')},
            ),
            SizedBox(height: 10),
            _GroupLabel(
              etiqueta: 'Asociaciones y desuentos pa...',
              text: "",
              press: () => {Navigator.pushNamed(context, 'postMainPage')},
            ),
            SizedBox(height: 10),
            _GroupLabel(
              etiqueta: 'Nuevo carnet universitario',
              text: "",
              press: () => {Navigator.pushNamed(context, 'postMainPage')},
            ),
            _GroupLabel(
              etiqueta: 'Código descuento burguer...',
              text: "",
              press: () => {Navigator.pushNamed(context, 'postMainPage')},
            ),
            _GroupLabel(
              etiqueta: 'Código decepcion Flutter',
              text: "",
              press: () => {Navigator.pushNamed(context, 'postMainPage')},
            ),
            _GroupLabel(
              etiqueta: 'Parking gratis CIU',
              text: "",
              press: () => {Navigator.pushNamed(context, 'postMainPage')},
            ),
            _GroupLabel(
              etiqueta: 'El nano no es humano',
              text: "",
              press: () => {Navigator.pushNamed(context, 'postMainPage')},
            ),
            _GroupLabel(
              etiqueta: 'Es superman',
              text: "",
              press: () => {Navigator.pushNamed(context, 'postMainPage')},
            ),
          ],
        ),
      ),
      bottomNavigationBar: navBar(),
    );
  }
}

class _GroupLabel extends StatelessWidget {
  const _GroupLabel({
    Key? key,
    required this.text,
    required this.etiqueta,
    this.press,
  }) : super(key: key);

  final String text;
  final String etiqueta;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Text(
              etiqueta,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(width: 20),
            Expanded(
                child:
                    Text(text, style: Theme.of(context).textTheme.bodyText2)),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0XFF283593),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupButtons extends StatelessWidget {
  const _GroupButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: Icon(Icons.add, color: Color(0XFF283593)),
              onPressed: () => {Navigator.pushNamed(context, 'newPostPage')}),
          SizedBox(width: 20),
          IconButton(
              icon: Icon(Icons.manage_search, color: Color(0XFF283593)),
              onPressed: () => {Navigator.pushNamed(context, 'manageGroups')}),
        ],
      ),
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  const _ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconButton icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            icon,
            SizedBox(width: 20),
            Expanded(
                child: Text(text, style: TextStyle(color: Color(0XFF283593)))),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0XFF283593),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfilePic extends StatelessWidget {
  const _ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/imgs/profile.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

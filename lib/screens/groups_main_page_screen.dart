// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_application_tfg/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupsMainPage extends StatefulWidget {
  @override
  State<GroupsMainPage> createState() => _GroupsMainPage();
}

class _GroupsMainPage extends State<GroupsMainPage> {
  late bool isAdmin;
  late User user;

  @override
  void initState() {
    super.initState();
    isAdmin = false;
    user = User(
        fullName: 'hola',
        password: 'ee',
        isAdmin: true,
        email: 'pepe',
        nick: 'papo');
  }

  void setAdmin(isAdmin) {
    setState(() {
      this.isAdmin = isAdmin;
    });
  }

  void setUser(user) {
    setState(() {
      this.user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService().isAdmin().then((value) => setAdmin(value));
    AuthService().getUser().then((value) => setUser(value));

    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              'Grupos',
              style: Theme.of(context).textTheme.headline3,
            ),
            _GroupButtons(),
            SizedBox(height: 10),
            _GroupLabel(
              etiqueta: 'MDL',
              text: "Mi cuenta",
              press: () => {Navigator.pushNamed(context, 'groupDetails')},
            ),
            SizedBox(height: 10),
            _GroupLabel(
              etiqueta: 'AW',
              text: "Mi cuenta",
              press: () => {Navigator.pushNamed(context, 'groupDetails')},
            ),
            SizedBox(height: 10),
            _GroupLabel(
              etiqueta: 'TFG',
              text: "Mi cuenta",
              press: () => {Navigator.pushNamed(context, 'groupDetails')},
            ),
            SizedBox(height: 10),
            _GroupLabel(
              etiqueta: 'IS',
              text: "Mi cuenta",
              press: () => {Navigator.pushNamed(context, 'groupDetails')},
            ),
            SizedBox(height: 10),
            _GroupLabel(
              etiqueta: 'BD',
              text: "Mi cuenta",
              press: () => {Navigator.pushNamed(context, 'groupDetails')},
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
              onPressed: () => {Navigator.pushNamed(context, 'newGroupPage')}),
          SizedBox(width: 20),
          IconButton(
              icon: Icon(Icons.manage_search, color: Color(0XFF283593)),
              onPressed: () => {Navigator.pushNamed(context, 'manageGroups')}),
          SizedBox(width: 20),
          IconButton(
              icon: Icon(Icons.checklist_sharp, color: Color(0XFF283593)),
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

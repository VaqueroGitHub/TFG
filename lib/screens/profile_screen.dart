// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_application_tfg/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            _ProfilePic(),
            SizedBox(height: 20),
            Text(
              user.nick,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 20),
            _ProfileMenu(
              text: "Mi cuenta",
              icon: IconButton(
                icon: SvgPicture.asset("assets/icons/User Icon.svg",
                    color: Color(0XFF283593)),
                onPressed: () {
                  Navigator.pushNamed(context, 'aboutProfile');
                },
              ),
              press: () => {Navigator.pushNamed(context, 'aboutProfile')},
            ),
            !isAdmin
                ? Container()
                : _ProfileMenu(
                    text: "Modo administrador",
                    icon: IconButton(
                      icon: SvgPicture.asset("assets/icons/Bell.svg",
                          color: Color(0XFF283593)),
                      onPressed: () {
                        Navigator.pushNamed(context, 'manageUsers');
                      },
                    ),
                    press: () => {Navigator.pushNamed(context, 'manageUsers')},
                  ),
            _ProfileMenu(
              text: "Modificar datos",
              icon: IconButton(
                icon: SvgPicture.asset("assets/icons/Settings.svg",
                    color: Color(0XFF283593)),
                onPressed: () {
                  Navigator.pushNamed(context, 'editProfile');
                },
              ),
              press: () {
                Navigator.pushNamed(context, 'editProfile');
              },
            ),
            _ProfileMenu(
              text: "Eliminar cuenta",
              icon: IconButton(
                icon: SvgPicture.asset("assets/icons/Delete.svg",
                    color: Color(0XFF283593)),
                onPressed: () async {
                  final resp = await AuthService().deleteAccount();
                  if (resp != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("ERROR LOGIN: $resp")));
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home', (Route<dynamic> route) => false);
                  }
                },
              ),
              press: () {},
            ),
            _ProfileMenu(
              text: "Log Out",
              icon: IconButton(
                icon: SvgPicture.asset("assets/icons/Log out.svg",
                    color: Color(0XFF283593)),
                onPressed: () {
                  AuthService().logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'home', (Route<dynamic> route) => false);
                },
              ),
              press: () {
                AuthService().logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, 'home', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: navBar(),
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

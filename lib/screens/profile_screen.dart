// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_application_tfg/styles/tfg_theme.dart';
import 'package:flutter_application_tfg/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            _ProfilePic(),
            SizedBox(height: 40),
            _ProfileMenu(
              text: "Mi cuenta",
              icon: "assets/icons/User Icon.svg",
              press: () => {},
            ),
            _ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            _ProfileMenu(
              text: "Modificar datos",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            _ProfileMenu(
              text: "Eliminar cuenta",
              icon: "assets/icons/Delete.svg",
              press: () {},
            ),
            IconButton(
              icon: SvgPicture.asset("assets/icons/Log out.svg",
                  color: Colors.yellow),
              onPressed: () {
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

  final String text, icon;
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
            SvgPicture.asset(
              icon,
              width: 22,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            Icon(Icons.arrow_forward_ios),
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

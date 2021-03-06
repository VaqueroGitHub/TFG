// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/edit_user_provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    final editUserProvider = Provider.of<EditUserProvider>(context);

    final double height = MediaQuery.of(context).size.height;
    return
        // Scaffold(
        //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //   floatingActionButton: FloatingActionButton(
        //     backgroundColor: Colors.indigo,
        //     onPressed: () => Navigator.pushReplacementNamed(
        //       context,
        //       'aboutProfile',
        //       arguments: UserArguments(
        //           user: userSessionProvider.user,
        //           id: userSessionProvider.user.id!,
        //           userSession: true),
        //     ),
        //     child: Icon(
        //       Icons.home,
        //       color: Colors.white,
        //     ),
        //   ),
        //   backgroundColor: Color(0xFFffffff),
        //   body:
        SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.04),
            Text(
              'Perfil',
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: height * 0.06),
            !userSessionProvider.user.isAdmin
                ? Container()
                : _ProfileMenu(
                    text: "Modo administrador",
                    icon: IconButton(
                      icon: SvgPicture.asset("assets/icons/Bell.svg",
                          color: Color(0XFF283593)),
                      onPressed: () =>
                          Navigator.pushNamed(context, 'adminHomePage'),
                    ),
                    press: () => Navigator.pushNamed(context, 'adminHomePage'),
                  ),
            _ProfileMenu(
              text: "Modificar datos",
              press: () {
                editUserProvider.user = userSessionProvider.user;
                Navigator.pushNamed(context, 'editProfile',
                    arguments: UserArguments(
                        user: userSessionProvider.user,
                        id: userSessionProvider.user.id!,
                        userSession: true));
              },
              icon: IconButton(
                icon: SvgPicture.asset("assets/icons/Settings.svg",
                    color: Color(0XFF283593)),
                onPressed: () {
                  editUserProvider.user = userSessionProvider.user;
                  Navigator.pushNamed(context, 'editProfile',
                      arguments: UserArguments(
                          user: userSessionProvider.user,
                          id: userSessionProvider.user.id!,
                          userSession: true));
                },
              ),
            ),
            _ProfileMenu(
              text: "Eliminar cuenta",
              press: () {
                _delete(context, userSessionProvider);
              },
              icon: IconButton(
                icon: SvgPicture.asset("assets/icons/Delete.svg",
                    color: Color(0XFF283593)),
                onPressed: () {
                  _delete(context, userSessionProvider);
                },
              ),
            ),
            _ProfileMenu(
              text: "Log Out",
              icon: IconButton(
                icon: SvgPicture.asset("assets/icons/Log out.svg",
                    color: Color(0XFF283593)),
                onPressed: () {
                  GetIt.I<AuthService>().logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'home', (Route<dynamic> route) => false);
                },
              ),
              press: () {
                GetIt.I<AuthService>().logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, 'home', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
    //   bottomNavigationBar: navBar(),
    // );
  }

  void _delete(BuildContext context, UserSessionProvider userSessionProvider) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Eliminar cuenta usuario'),
            content: const Text(
                '??Esta seguro/a de que quiere borrar su cuenta? Perder?? todos sus datos.'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () async {
                    // Close the dialog
                    Navigator.of(context).pop();

                    final resp = await GetIt.I<AuthService>()
                        .deleteAccount(userSessionProvider.user);
                    if (resp != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("ERROR: $resp")));
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'home', (Route<dynamic> route) => false);
                    }
                  },
                  child: const Text('Confirmar')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No!'))
            ],
          );
        });
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

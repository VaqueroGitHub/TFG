import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: AuthService().isAuth(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Text('Cargando..');

          Future.microtask(() {
            if (snapshot.data == '') {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'home', (Route<dynamic> route) => false);
            } else {
              final userSessionProvider =
                  Provider.of<UserSessionProvider>(context, listen: false);
              userSessionProvider.loadUserInfo().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'profile', (Route<dynamic> route) => false));
            }
          });

          return Container();
        },
      )),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('UCM TFG'),
          elevation: 0,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tarjetas principales
            ElevatedButton(
              child: const Text('Register'),
              onPressed: () {
                _navigateToRegisterScreen(context);
              },
            ),
            ElevatedButton(
              child: const Text('Log In'),
              onPressed: () {
                _navigateToLogInScreen(context);
              },
            ),
            // Pagina de log in
          ],
        )));
  }

  void _navigateToLogInScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LogInScreen()));
  }

  //Navigator.pushNamed(context, routeName) con las rutas definidas en el main
  // onGenerateRoute para  rutas  dinamicas
  void _navigateToRegisterScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
  }
}

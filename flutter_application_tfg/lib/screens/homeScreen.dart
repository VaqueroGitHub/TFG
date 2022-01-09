import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(
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

  void _navigateToRegisterScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
  }
}

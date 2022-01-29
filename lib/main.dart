import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/screens/screens.dart';
import 'package:flutter_application_tfg/styles/tfg_theme.dart';

void main() {
  runApp(const MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nombre App',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'register': (_) => RegisterScreen(),
        'logIn': (_) => LogInScreen(),
        'profile': (_) => ProfileScreen(),
      },
      theme: tfgTheme.copyWith(
          appBarTheme: const AppBarTheme(color: Colors.transparent)),
    );
  }
}

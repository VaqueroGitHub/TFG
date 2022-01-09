import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/screens/screens.dart';

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
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.red)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApplication(),
    );
  }
}

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nombre app',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'register': (_) => RegisterScreen(),
        'logIn': (_) => LogInScreen(),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: AppBarTheme(color: Colors.indigo)),
    );
  }
}

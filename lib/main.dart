import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/user_login_provider.dart';
import 'package:flutter_application_tfg/providers/user_register_provider.dart';
import 'package:flutter_application_tfg/screens/screens.dart';
import 'package:flutter_application_tfg/styles/tfg_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserLoginProvider()),
        ChangeNotifierProvider(create: (_) => UserRegisterProvider()),
      ],
      child: MyApplication(),
    );
  }
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
        'editProfile': (_) => EditProfilePage(),
      },
      theme: tfgTheme.copyWith(
          appBarTheme: const AppBarTheme(color: Colors.transparent)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/widgets/form%20login.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          elevation: 0,
        ),
        body: SingleChildScrollView(child: MyStatefulWidget()));
  }
}

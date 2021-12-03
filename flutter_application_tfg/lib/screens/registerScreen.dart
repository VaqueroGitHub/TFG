import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/widgets/form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
          elevation: 0,
        ),
        body: SingleChildScrollView(child: MyStatefulWidget()));
  }
}

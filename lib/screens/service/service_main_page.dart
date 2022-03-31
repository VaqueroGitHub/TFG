import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/widgets/nav_bar.dart';

class ServiceMainPage extends StatelessWidget {
  const ServiceMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Servicios')),
      bottomNavigationBar: navBar(),
    );
  }
}

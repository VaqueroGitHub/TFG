import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFffffff),
        body: Container(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  Text(
                    '¡Bienvenido a TFG UCM!',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    'Rellena tus datos 📝',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Introduce tu nombre completo"),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText:
                            "Introduce tu alias (será tu nombre público)"),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Introduce tu correo universitario"),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Introduce tu contraseña"),
                    obscureText: true,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Confirma tu contraseña"),
                    obscureText: true,
                  ),
                  SizedBox(height: height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        elevation: 10.0,
                        minWidth: 170.0,
                        height: 50.0,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'home');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

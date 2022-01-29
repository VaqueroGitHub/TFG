import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFffffff),
        body: _LoginBody(height: height));
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: _LoginForm(height: height)));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.04),
          Text(
            '¡Qué alegría',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            'verte de nuevo! 📚',
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: height * 0.08),
          TextFormField(
            decoration: const InputDecoration(
                labelText: "Introduce tu correo universitario"),
          ),
          SizedBox(height: height * 0.04),
          TextFormField(
            decoration:
                const InputDecoration(labelText: "Introduce tu contraseña"),
            obscureText: true,
          ),
          SizedBox(height: height * 0.08),
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
                  'Iniciar sesión',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'home');
                },
              ),
            ],
          ),
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text(
                  '¿Aún sin cuenta? Regístrate 😏',
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'register');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

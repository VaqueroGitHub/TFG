import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/user_register_provider.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:provider/provider.dart';

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
        body: _RegisterBody(height: height));
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final userRegisterProvider = Provider.of<UserRegisterProvider>(context);

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Form(
              key: userRegisterProvider.formKey,
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
                    onChanged: (val) => userRegisterProvider.fullName = val,
                    decoration: const InputDecoration(
                        labelText: "Introduce tu nombre completo"),
                    minLines: 1,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => userRegisterProvider.nick = val,
                    decoration: const InputDecoration(
                        labelText:
                            "Introduce tu alias (será tu nombre público)"),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => userRegisterProvider.email = val,
                    decoration: const InputDecoration(
                        labelText: "Introduce tu correo universitario"),
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => userRegisterProvider.password = val,
                    decoration: const InputDecoration(
                        labelText: "Introduce tu contraseña"),
                    obscureText: true,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) =>
                        userRegisterProvider.confirmPassword = val,
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
                        onPressed: userRegisterProvider.isLoading
                            ? null
                            : () async {
                                // if (!userRegisterProvider.isValidForm()) return;

                                userRegisterProvider.isLoading = true;
                                final String? errorMessage = await AuthService()
                                    .signUpUser(userRegisterProvider.user());

                                if (errorMessage == null) {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      'home', (Route<dynamic> route) => false);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "ERROR LOGIN: $errorMessage")));
                                }

                                userRegisterProvider.isLoading = false;
                              },
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

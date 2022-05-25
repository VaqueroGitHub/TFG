import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/user_register_provider.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class NewSubforumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFffffff),
        body: _NewSubforumPage(height: height));
  }
}

class _NewSubforumPage extends StatelessWidget {
  const _NewSubforumPage({
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
                    'Estás a punto de crear un subforo',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    'Escoge un nombre con gancho🤔',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    // onChanged: (val) => userRegisterProvider.fullName = val,
                    decoration:
                        const InputDecoration(labelText: "Introduce el título"),
                    minLines: 1,
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
                          'Crear grupo',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: userRegisterProvider.isLoading
                            ? null
                            : () async {
                                // if (!userRegisterProvider.isValidForm()) return;

                                userRegisterProvider.isLoading = true;
                                final String? errorMessage =
                                    await GetIt.I<AuthService>().signUpUser(
                                        userRegisterProvider.user());

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

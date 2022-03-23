import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/user_register_provider.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:provider/provider.dart';

class NewPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFffffff),
        body: _NewGroupPage(height: height));
  }
}

class _NewGroupPage extends StatelessWidget {
  const _NewGroupPage({
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
                    '¿Quieres crear un nuevo post?',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: height * 0.04),
                  Text(
                    'Lo incluiremos en General 🤔',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    // onChanged: (val) => userRegisterProvider.fullName = val,
                    maxLength: 20,
                    decoration:
                        const InputDecoration(labelText: "Introduce el título"),
                    minLines: 1,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    // onChanged: (val) => userRegisterProvider.nick = val,
                    maxLength: 500,
                    decoration:
                        const InputDecoration(labelText: "Introduce el texto"),
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
                          'Crear post',
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

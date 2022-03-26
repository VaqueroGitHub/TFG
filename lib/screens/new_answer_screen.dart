import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/post.dart';
import 'package:flutter_application_tfg/providers/user_register_provider.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../models/answer.dart';
import '../providers/user_session_provider.dart';
import '../services/answer_database_service.dart';

class NewAnswerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFffffff),
        body: _NewAnswerPage(height: height));
  }
}

class _NewAnswerPage extends StatelessWidget {
  const _NewAnswerPage({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final userSessionProvider = Provider.of<UserSessionProvider>(context);

    //creo un objeto grupo
    Answer answer = new Answer(
      answer: '',
      idPost: '',
      idUser: userSessionProvider.id,
    );

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  Text(
                    'Preparate para añadir la respuesta',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    'Gracias por compartir tus ideas',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (val) => answer.answer = val,
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
                          'Responder',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          if (answer.answer != '') {
                            AnswerDatabaseService()
                                .updateAnswer(answer, userSessionProvider.id);
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                'forumMainPage',
                                (Route<dynamic> route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("RELLENA TODOS LOS CAMPOS")));
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

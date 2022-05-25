import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/answer_form_provider.dart';
import 'package:flutter_application_tfg/providers/post_main_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/post_arguments.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../../providers/user_session_provider.dart';
import '../../services/answer_database_service.dart';

class NewAnswerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: Colors.black,
              )),
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
    final answerFormProvider = Provider.of<AnswerFormProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as PostArguments;

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Form(
              key: answerFormProvider.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    onChanged: (val) => answerFormProvider.answerBody = val,
                    validator: (val) {
                      if (val == null || val.length < 2 || val.length > 500)
                        return 'Introduzca una respuesta valida';
                    },
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
                          if (!answerFormProvider.isValidForm()) return;
                          answerFormProvider.idPost = args.post!.id!;
                          answerFormProvider.idUser =
                              userSessionProvider.user.id!;
                          await GetIt.I<AnswerService>()
                              .updateAnswer(answerFormProvider.answer(), null);
                          final postMainProvider =
                              Provider.of<PostMainProvider>(context,
                                  listen: false);
                          await postMainProvider.loadPost(args.post!.id!);
                          postMainProvider.notifyListeners();
                          Navigator.pop(context, args);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

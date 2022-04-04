import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/forum_list_provider.dart';
import 'package:flutter_application_tfg/providers/post_form_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/forum_arguments.dart';
import 'package:provider/provider.dart';
import '../../providers/user_session_provider.dart';
import '../../services/post_database_service.dart';

class NewPostPage extends StatelessWidget {
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
        body: _NewPostPage(height: height));
  }
}

class _NewPostPage extends StatelessWidget {
  const _NewPostPage({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    final postFormProvider = Provider.of<PostFormProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as ForumArguments;
    //creo un objeto grupo

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Form(
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
                    'Lo incluiremos en ${args.forumSection.title} 🤔',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    onChanged: (val) => postFormProvider.title = val,
                    maxLength: 20,
                    decoration:
                        const InputDecoration(labelText: "Introduce el título"),
                    minLines: 1,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (val) => postFormProvider.body = val,
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
                        onPressed: () async {
                          if (postFormProvider.title != '' &&
                              postFormProvider.body != '') {
                            postFormProvider.idForumSection =
                                args.forumSection.id!;
                            postFormProvider.idUser =
                                userSessionProvider.user.id!;
                            PostDatabaseService().updatePost(
                                postFormProvider.post(),
                                userSessionProvider.user.id!);

                            final forumListProvider =
                                Provider.of<ForumListProvider>(context,
                                    listen: false);
                            forumListProvider
                                .loadPostList(args.forumSection.id!);
                            Navigator.pop(context);
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

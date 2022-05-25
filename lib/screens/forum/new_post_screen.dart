import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/forum_list_provider.dart';
import 'package:flutter_application_tfg/providers/post_form_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/post_arguments.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../../providers/user_session_provider.dart';
import '../../services/post_service.dart';

class NewPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context, null),
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
    final args = ModalRoute.of(context)!.settings.arguments as PostArguments;
    //creo un objeto grupo

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Form(
              key: postFormProvider.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  Text(
                    args.isEditing
                        ? 'Edicion del post'
                        : '¿Quieres crear un nuevo post?',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: height * 0.04),
                  args.isEditing
                      ? Text(
                          'Lo incluiremos en ${args.forumSection.title} 🤔',
                          style: Theme.of(context).textTheme.headline4,
                        )
                      : Container(),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    initialValue: args.isEditing ? args.post!.title : '',
                    onChanged: (val) => postFormProvider.title = val,
                    maxLength: 20,
                    validator: (val) {
                      if (val == null || val.length < 2 || val.length > 20)
                        return 'Introduce un titulo de post valido.';
                    },
                    decoration:
                        const InputDecoration(labelText: "Introduce el título"),
                    minLines: 1,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    initialValue: args.isEditing ? args.post!.body : '',
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (val) => postFormProvider.body = val,
                    validator: (val) {
                      if (val == null || val.length < 10 || val.length > 500)
                        return 'Introduce una descripcion de post valida.';
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
                        child: Text(
                          args.isEditing ? 'Editar post' : 'Crear post',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          if (!postFormProvider.isValidForm()) return;

                          postFormProvider.idForumSection =
                              args.forumSection.id!;
                          postFormProvider.idUser =
                              userSessionProvider.user.id!;
                          GetIt.I<PostService>().updatePost(
                              args.isEditing
                                  ? postFormProvider.postWithId(args.post!.id!)
                                  : postFormProvider.post(),
                              userSessionProvider.user.id!);

                          final forumListProvider =
                              Provider.of<ForumListProvider>(context,
                                  listen: false);
                          await forumListProvider
                              .loadPostList(args.forumSection.id!);
                          forumListProvider.notifyListeners();
                          Navigator.pop(
                              context,
                              args.isEditing
                                  ? await GetIt.I<PostService>()
                                      .getPostData(args.post!.id!)
                                  : null);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

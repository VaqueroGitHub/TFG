import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/group_list_provider.dart';
import 'package:flutter_application_tfg/providers/message_form_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/group_arguments.dart';
import 'package:flutter_application_tfg/services/message_group_database_service.dart';
import 'package:provider/provider.dart';
import '../../providers/user_session_provider.dart';

class NewGroupMessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context)),
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
    final messageFormProvider = Provider.of<MessageFormProvider>(context);
    final args = ModalRoute.of(context)!.settings.arguments as GroupArguments;

    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  Text(
                    'Nuevo mensaje para el grupo',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: height * 0.04),
                  TextFormField(
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (val) => messageFormProvider.message = val,
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
                          'Añadir',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          if (messageFormProvider.message != '') {
                            messageFormProvider.idGroup = args.group.id!;
                            messageFormProvider.idUser =
                                userSessionProvider.user.id!;
                            await MessageGroupDatabaseService()
                                .updateGroupMessage(
                                    messageFormProvider.groupMessage(), null);
                            await Provider.of<GroupListProvider>(context,
                                    listen: false)
                                .loadMessagesGroupList(args.group.id!);
                            Navigator.pop(context, args);
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

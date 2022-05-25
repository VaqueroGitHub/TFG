import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/providers/edit_user_provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_application_tfg/services/user_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ManageUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final editUserProvider = Provider.of<EditUserProvider>(context);
    return FutureBuilder<List<User>>(
        future: getUserList(context),
        initialData: [],
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            final List<User> listUser = snapshot.data!;
            return ListView.builder(
              itemCount: listUser.length,
              itemBuilder: (_, index) {
                return Material(
                  child: ListTile(
                    title: Text(listUser[index].fullName),
                    subtitle: Text(listUser[index].email),
                    trailing: Wrap(
                      spacing: 12, // space between two icons
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            editUserProvider.user = listUser[index];
                            editUserProvider.notifyListeners();
                            Navigator.pushNamed(context, 'editProfile',
                                arguments: UserArguments(
                                    user: listUser[index],
                                    id: listUser[index].id!,
                                    userSession: false));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            final resp = await GetIt.I<AuthService>()
                                .deleteAccount(listUser[index]);
                            if (resp != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("ERROR: $resp")));
                            } else {
                              Navigator.popAndPushNamed(
                                  context, "adminHomePage");
                              //     (Route<dynamic> route) => false); // push it back in
                              //getUserList(context);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<List<User>> getUserList(context) async {
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    List<User> listUser = await GetIt.I<UserService>().getAllUsersAdmin();
    return listUser;
  }
}

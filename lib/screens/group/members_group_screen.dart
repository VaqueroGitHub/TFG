import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/screen_arguments/group_arguments.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:flutter_application_tfg/services/group_service.dart';
import 'package:get_it/get_it.dart';

class MembersGroupScreen extends StatelessWidget {
  const MembersGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as GroupArguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFffffff),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'Miembros',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: FutureBuilder<List<User>>(
            future: getUserList(args.group!.idMembers),
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
                        onTap: () => Navigator.pushNamed(context, 'seeProfile',
                            arguments: UserArguments(
                                user: listUser[index],
                                id: listUser[index].id!,
                                userSession: true)),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Future<List<User>> getUserList(idMembers) async {
    List<User> listUser =
        await GetIt.I<GroupService>().getMembersGroup(idMembers);
    return listUser;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/group.dart';
import 'package:flutter_application_tfg/providers/group_list_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/group_arguments.dart';
import 'package:flutter_application_tfg/services/group_database_service.dart';
import 'package:provider/provider.dart';

class ManageGroupsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Consumer<GroupListProvider>(
        builder: (context, providerData, _) => FutureBuilder<List<Group>>(
            future: providerData.loadAllGroupList(),
            builder: (context, AsyncSnapshot<List<Group>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("Loading..."));
              }

              List<Group> groupList = snapshot.data!;

              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: groupList.length,
                  itemBuilder: (context, index) {
                    return Material(
                      child: ListTile(
                        title: Text(groupList[index].asignatura),
                        subtitle: Text('Tamaño: ' +
                            groupList[index].idMembers.length.toString() +
                            '/' +
                            groupList[index].nMembersRequired.toString() +
                            ' miembros'),
                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushNamed(context, 'groupDetails',
                                    arguments: GroupArguments(
                                        group: groupList[index],
                                        userSession: false));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await GroupDatabaseService()
                                    .deleteGroup(groupList[index].id!);

                                Navigator.popAndPushNamed(
                                    context, 'adminHomePage',
                                    arguments: 2);
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}

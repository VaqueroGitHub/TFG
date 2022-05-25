// ignore_for_file: file_names
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/group.dart';
import 'package:flutter_application_tfg/models/group_message.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/providers/group_details_provider.dart';
import 'package:flutter_application_tfg/providers/group_form_provider.dart';
import 'package:flutter_application_tfg/providers/group_list_provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/group_arguments.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:flutter_application_tfg/services/group_service.dart';
import 'package:flutter_application_tfg/widgets/answer_post.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as GroupArguments;
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    final groupDetailsProvider = Provider.of<GroupDetailsProvider>(context);
    final groupFormProvider = Provider.of<GroupFormProvider>(context);
    final groupListProvider = Provider.of<GroupListProvider>(context);

    return Builder(
      builder: (context) => Scaffold(
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
            'Grupo',
            style: Theme.of(context).textTheme.headline3,
          ),
          actions: [
            groupDetailsProvider.group!.idUser == userSessionProvider.user.id
                ? IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      groupFormProvider.setGroup(args.group!);
                      final group = await Navigator.pushNamed(
                          context, 'newGroupPage',
                          arguments: GroupArguments(
                              group: groupDetailsProvider.group!,
                              userSession: true,
                              isEditing: true));
                      if (group != null) {
                        groupDetailsProvider.group = group as Group;
                        groupDetailsProvider.notifyListeners();
                      }
                    },
                  )
                : Container(),
            groupDetailsProvider.group!.idUser == userSessionProvider.user.id
                ? IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      await GetIt.I<GroupService>()
                          .deleteGroup(groupDetailsProvider.group!.id!);
                      await groupListProvider
                          .loadUserGroupList(userSessionProvider.user.id!);
                      Navigator.pop(context);
                    },
                  )
                : Container()
          ],
        ),
        backgroundColor: Color(0xFFffffff),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            GroupNumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(context),
            const SizedBox(height: 48),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _InfoLinks(),
                userSessionProvider.user.id ==
                            groupDetailsProvider.group!.idUser ||
                        groupDetailsProvider.group!.idMembers
                            .contains(userSessionProvider.user.id) ||
                        groupDetailsProvider.group!.idMembers.length >=
                            groupDetailsProvider.group!.nMembersRequired
                    ? Container()
                    : MaterialButton(
                        elevation: 10.0,
                        minWidth: 200.0,
                        height: 50.0,
                        color: userSessionProvider.user.id ==
                                    groupDetailsProvider.group!.idUser ||
                                groupDetailsProvider.group!.idMembers
                                    .contains(userSessionProvider.user.id) ||
                                groupDetailsProvider.group!.idMembers.length >=
                                    groupDetailsProvider.group!.nMembersRequired
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          userSessionProvider.user.id ==
                                      groupDetailsProvider.group!.idUser ||
                                  groupDetailsProvider.group!.idMembers
                                      .contains(userSessionProvider.user.id) ||
                                  groupDetailsProvider
                                          .group!.idMembers.length >=
                                      groupDetailsProvider
                                          .group!.nMembersRequired
                              ? 'Ya inscirto'
                              : 'Únete',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          if (userSessionProvider.user.id ==
                                  groupDetailsProvider.group!.idUser ||
                              groupDetailsProvider.group!.idMembers
                                  .contains(userSessionProvider.user.id) ||
                              groupDetailsProvider.group!.idMembers.length >=
                                  groupDetailsProvider.group!.nMembersRequired)
                            return;

                          await GetIt.I<GroupService>().joinGroup(
                              groupDetailsProvider.group!,
                              userSessionProvider.user.id!);

                          args.userSession
                              ? Navigator.popAndPushNamed(
                                  context, 'groupsMainPage')
                              : Navigator.popAndPushNamed(
                                  context, 'adminHomePage',
                                  arguments: 2);
                        },
                      ),
                SizedBox(
                  height: 20,
                ),
                userSessionProvider.user.id ==
                            groupDetailsProvider.group!.idUser ||
                        !groupDetailsProvider.group!.idMembers
                            .contains(userSessionProvider.user.id)
                    ? Container()
                    : MaterialButton(
                        elevation: 10.0,
                        minWidth: 200.0,
                        height: 50.0,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Salir del grupo',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          await GetIt.I<GroupService>().exitGroup(
                              groupDetailsProvider.group!,
                              userSessionProvider.user.id!);

                          args.userSession
                              ? Navigator.popAndPushNamed(
                                  context, 'groupsMainPage')
                              : Navigator.popAndPushNamed(
                                  context, 'adminHomePage',
                                  arguments: 2);
                        },
                      ),
                SizedBox(height: 20),
                userSessionProvider.user.id ==
                            groupDetailsProvider.group!.idUser ||
                        groupDetailsProvider.group!.idMembers
                            .contains(userSessionProvider.user.id)
                    ? _ChatCardWidget()
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildName(BuildContext context, User user) => Column(
        children: [
          Text(
            user.nick,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(BuildContext context) {
    final groupDetailsProvider = Provider.of<GroupDetailsProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Qué busca el grupo? 👨🏻‍🎓',
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 16),
          Text(
            groupDetailsProvider.group!.description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

void _launchURL(_url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}

class _ChatCardWidget extends StatelessWidget {
  const _ChatCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupDetailsProvider = Provider.of<GroupDetailsProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTileCard(
        //key: GlobalKey(),
        leading: Icon(Icons.chat),
        title: Text('Chat de grupo!'),
        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          TextButton(
              onPressed: () => Navigator.pushNamed(context, 'newGroupMessage',
                  arguments: GroupArguments(
                      group: groupDetailsProvider.group!,
                      userSession: true,
                      isEditing: false)),
              child: Text("Nuevo mensaje")),
          _ListChatGroup(),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[],
          ),
        ],
      ),
    );
  }
}

class _ListChatGroup extends StatelessWidget {
  const _ListChatGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as GroupArguments;
    //final groupListProvider2 = Provider.of<GroupListProvider>(context);

    return Consumer<GroupListProvider>(
        builder: (context, groupListProvider, child) {
      //groupListProvider.loadMessagesGroupList(args.group.id!);

      return FutureBuilder<List<GroupMessage>>(
          future: groupListProvider.loadMessagesGroupList(args.group!.id!),
          builder: (context, AsyncSnapshot<List<GroupMessage>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text("Loading..."));
            }
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: groupListProvider.listMessage.length,
                itemBuilder: (context, index) {
                  return Material(
                    child: AnswerPost(
                      PostEntry(
                          groupListProvider.listMessage[index].user!.nick,
                          groupListProvider.listMessage[index].message,
                          groupListProvider.listMessage[index].user!,
                          groupListProvider
                              .listMessage[index].dateTimeToString),
                    ),
                  );
                });
          });
    });
  }
}

class _InfoLinks extends StatelessWidget {
  const _InfoLinks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupDetailsProvider = Provider.of<GroupDetailsProvider>(context);
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        !groupDetailsProvider.group!.githUrl.isEmpty &&
                (userSessionProvider.user.id ==
                        groupDetailsProvider.group!.idUser ||
                    groupDetailsProvider.group!.idMembers
                        .contains(userSessionProvider.user.id))
            ? TextButton(
                child: Text("🖥️ Github repo "),
                onPressed: () =>
                    _launchURL(groupDetailsProvider.group!.githUrl),
              )
            : Container(),
        SizedBox(height: 20),
        !groupDetailsProvider.group!.driveUrl.isEmpty &&
                (userSessionProvider.user.id ==
                        groupDetailsProvider.group!.idUser ||
                    groupDetailsProvider.group!.idMembers
                        .contains(userSessionProvider.user.id))
            ? TextButton(
                child: Text("🗂️ Drive storage "),
                onPressed: () =>
                    _launchURL(groupDetailsProvider.group!.driveUrl),
              )
            : Container(),
        SizedBox(height: 20),
      ],
    );
  }
}

class GroupNumbersWidget extends StatelessWidget {
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text,
          String? onPressedRoute, dynamic? onPressedArgs) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: onPressedRoute != null
            ? () => Navigator.pushNamed(context, onPressedRoute,
                arguments: onPressedArgs!)
            : null,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final groupDetailsProvider = Provider.of<GroupDetailsProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildButton(
            context,
            (groupDetailsProvider.group!.idMembers.length).toString() +
                '/' +
                groupDetailsProvider.group!.nMembersRequired.toString(),
            'Miembros',
            'membersScreen',
            GroupArguments(
                userSession: true,
                isEditing: false,
                group: groupDetailsProvider.group!)),
        buildDivider(),
        Hero(
          tag: groupDetailsProvider.group!.asignatura,
          child: buildButton(context, groupDetailsProvider.group!.asignatura,
              'Asignatura', null, null),
        ),
        buildDivider(),
        buildButton(
            context,
            groupDetailsProvider.group!.user!.nick,
            'Propietario',
            'seeProfile',
            UserArguments(
                user: groupDetailsProvider.group!.user!,
                id: groupDetailsProvider.group!.user!.id!,
                userSession: true)),
      ],
    );
  }
}

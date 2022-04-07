// ignore_for_file: file_names
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/group_arguments.dart';
import 'package:flutter_application_tfg/services/group_database_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as GroupArguments;
    final userSessionProvider = Provider.of<UserSessionProvider>(context);

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
            )),
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
                userSessionProvider.user.id == args.group.idUser ||
                        args.group.idMembers
                            .contains(userSessionProvider.user.id) ||
                        args.group.idMembers.length >=
                            args.group.nMembersRequired
                    ? Container()
                    : MaterialButton(
                        elevation: 10.0,
                        minWidth: 200.0,
                        height: 50.0,
                        color: userSessionProvider.user.id ==
                                    args.group.idUser ||
                                args.group.idMembers
                                    .contains(userSessionProvider.user.id) ||
                                args.group.idMembers.length >=
                                    args.group.nMembersRequired
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          userSessionProvider.user.id == args.group.idUser ||
                                  args.group.idMembers
                                      .contains(userSessionProvider.user.id) ||
                                  args.group.idMembers.length >=
                                      args.group.nMembersRequired
                              ? 'Ya inscirto'
                              : 'Únete',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          if (userSessionProvider.user.id ==
                                  args.group.idUser ||
                              args.group.idMembers
                                  .contains(userSessionProvider.user.id) ||
                              args.group.idMembers.length >=
                                  args.group.nMembersRequired) return;

                          await GroupDatabaseService().joinGroup(
                              args.group, userSessionProvider.user.id!);

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
                userSessionProvider.user.id == args.group.idUser ||
                        !args.group.idMembers
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
                          await GroupDatabaseService().exitGroup(
                              args.group, userSessionProvider.user.id!);

                          args.userSession
                              ? Navigator.popAndPushNamed(
                                  context, 'groupsMainPage')
                              : Navigator.popAndPushNamed(
                                  context, 'adminHomePage',
                                  arguments: 2);
                        },
                      ),
                SizedBox(height: 20),
                userSessionProvider.user.id != args.group.idUser
                    ? Container()
                    : MaterialButton(
                        elevation: 10.0,
                        minWidth: 200.0,
                        height: 50.0,
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Eliminar',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          await GroupDatabaseService()
                              .deleteGroup(args.group.id!);

                          args.userSession
                              ? Navigator.popAndPushNamed(
                                  context, 'groupsMainPage')
                              : Navigator.popAndPushNamed(
                                  context, 'adminHomePage',
                                  arguments: 2);
                        },
                      ),
                _ChatCardWidget(),
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
    final args = ModalRoute.of(context)!.settings.arguments as GroupArguments;
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
            args.group.description,
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
    return ExpansionTileCard(
      key: GlobalKey(),
      leading: Icon(Icons.chat),
      title: Text('Chat de grupo!'),
      //subtitle: Text('I expand!'),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.

Use me any time you think your app could benefit from being just a bit more Material.

These buttons control the next card down!""",
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          buttonHeight: 52.0,
          buttonMinWidth: 90.0,
          children: <Widget>[],
        ),
      ],
    );
  }
}

class _InfoLinks extends StatelessWidget {
  const _InfoLinks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          child: Text("🖥️ Github repo "),
          onPressed: () => _launchURL("https://github.com/"),
        ),
        SizedBox(height: 20),
        TextButton(
          child: Text("🗂️ Drive storage "),
          onPressed: () => _launchURL("https://drive.google.com/"),
        ),
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

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
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
    final args = ModalRoute.of(context)!.settings.arguments as GroupArguments;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildButton(
            context,
            (args.group.idMembers.length).toString() +
                '/' +
                args.group.nMembersRequired.toString(),
            'Miembros'),
        buildDivider(),
        buildButton(context, args.group.asignatura, 'Asignatura'),
        buildDivider(),
        buildButton(context, args.group.user!.nick, 'Propietario'),
      ],
    );
  }
}

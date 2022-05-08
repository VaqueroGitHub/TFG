import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:flutter_application_tfg/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SeeProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;
    final userSessionProvider = Provider.of<UserSessionProvider>(context);

    return Builder(
      builder: (context) => Scaffold(
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
        backgroundColor: Colors.white,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            ProfileWidget(
              isEdit: false,
              fileImage: args.user.url,
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            buildName(context, args.user),
            const SizedBox(height: 24),
            NumbersWidget(userId: args.user.id!),
            const SizedBox(height: 48),
            buildAbout(context, args.user),
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

  Widget buildAbout(BuildContext context, User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sobre mi 👨🏻‍🎓',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 16),
            Text(
              user.bio,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      );
}

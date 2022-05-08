import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:flutter_application_tfg/screens/home_page.dart';
import 'package:flutter_application_tfg/widgets/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AboutProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;
    final userSessionProvider = Provider.of<UserSessionProvider>(context);

    return Builder(
      builder: (context) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
                padding: EdgeInsets.all(20),
                onPressed: () =>
                    //Navigator.pushReplacementNamed(context, 'homePage'),
                    Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(milliseconds: 700),
                          type: PageTransitionType.scale,
                          alignment: Alignment.bottomRight,
                          child: HomePage()),
                    ),
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                  size: 35,
                )),
          ),
          //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          //   floatingActionButton: FloatingActionButton(
          //     backgroundColor: Colors.indigo,
          //     onPressed: () => Navigator.pushReplacementNamed(
          //       context,
          //       'aboutProfile',
          //       arguments: UserArguments(
          //           user: userSessionProvider.user,
          //           id: userSessionProvider.user.id!,
          //           userSession: true),
          //     ),
          //     child: IconButton(
          //       onPressed: () => Navigator.pushReplacementNamed(
          //         context,
          //         'aboutProfile',
          //         arguments: UserArguments(
          //             user: userSessionProvider.user,
          //             id: userSessionProvider.user.id!,
          //             userSession: true),
          //       ),
          //       icon: Icon(
          //         Icons.home,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          //   backgroundColor: Colors.white,
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),
              ProfileWidget(
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
          )
          //   bottomNavigationBar: navBar(),
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

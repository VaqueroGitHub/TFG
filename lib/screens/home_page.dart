import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/ui_provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:flutter_application_tfg/screens/screens.dart';
import 'package:flutter_application_tfg/screens/service/service_main_page.dart';
import 'package:flutter_application_tfg/widgets/custom_navigation_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              padding: EdgeInsets.all(20),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                      settings: RouteSettings(
                        name: 'aboutProfile',
                        arguments: UserArguments(
                            user: userSessionProvider.user,
                            id: userSessionProvider.user.id!,
                            userSession: true),
                      ),
                      duration: Duration(milliseconds: 700),
                      type: PageTransitionType.scale,
                      alignment: Alignment.topLeft,
                      child: AboutProfilePage(),
                    ));
              },
              icon: Icon(
                Icons.person_outline,
                color: Colors.black,
                size: 35,
              ))),
      body: _HomePageBody(uiProvider: uiProvider),
      bottomNavigationBar: CustomNavigationBar(),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterFloat,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.indigo,
      //   onPressed: () => Navigator.pushReplacementNamed(
      //     context,
      //     'aboutProfile',
      //     arguments: UserArguments(
      //         user: userSessionProvider.user,
      //         id: userSessionProvider.user.id!,
      //         userSession: true),
      //   ),
      //   child: IconButton(
      //     onPressed: () => Navigator.pushReplacementNamed(
      //       context,
      //       'aboutProfile',
      //       arguments: UserArguments(
      //           user: userSessionProvider.user,
      //           id: userSessionProvider.user.id!,
      //           userSession: true),
      //     ),
      //     icon: Icon(
      //       Icons.home,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  final uiProvider;

  const _HomePageBody({Key? key, required this.uiProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (uiProvider.currentNavigatorIndex) {
      case 0:
        return ServiceMainPage();
      case 1:
        return GroupsMainPage();
      case 2:
        return ForumMainPage();
      case 3:
        return ProfileScreen();
      default:
        return AboutProfilePage();
    }
  }
}

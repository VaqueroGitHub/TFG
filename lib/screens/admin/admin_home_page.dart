import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/screens/admin/manage_services_screen.dart';
import 'package:flutter_application_tfg/screens/screens.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialIndex = ModalRoute.of(context)!.settings.arguments;

    return Material(
      child: DefaultTabController(
          length: 4, // length of tabs
          initialIndex: initialIndex != null ? initialIndex as int : 0,
          child: Scaffold(
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
                'Panel Administración',
                style: Theme.of(context).textTheme.headline4,
              ),
              bottom: const TabBar(
                labelColor: Colors.black,
                tabs: [
                  Tab(text: 'Usuarios'),
                  Tab(text: 'Foros'),
                  Tab(text: 'Grupos'),
                  Tab(text: 'Servicios'),
                ],
              ),
            ),
            backgroundColor: Color(0xFFffffff),
            body: TabBarView(children: <Widget>[
              ManageUsersScreen(),
              ManagePostsScreen(),
              ManageGroupsScreen(),
              ManageServicesScreen(),
            ]),
          )),
    );
  }
}

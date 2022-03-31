import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/screens/screens.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialIndex = ModalRoute.of(context)!.settings.arguments;

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
            'Panel Administración',
            style: Theme.of(context).textTheme.headline4,
          )),
      backgroundColor: Color(0xFFffffff),
      body: SafeArea(
        child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20.0),
                // Text('Panel Administración',
                //     textAlign: TextAlign.center,
                //     style: TextStyle(fontSize: 22)),
                DefaultTabController(
                    length: 4, // length of tabs
                    initialIndex:
                        initialIndex != null ? initialIndex as int : 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: TabBar(
                              labelColor: Colors.indigo,
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(text: 'Usuarios'),
                                Tab(text: 'Foros'),
                                Tab(text: 'Grupos'),
                                Tab(text: 'Servicios'),
                              ],
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height - 170,
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.grey, width: 0.5))),
                              child: TabBarView(children: <Widget>[
                                ManageUsersScreen(),
                                ManagePostsScreen(),
                                ManageGroupsScreen(),
                                Container(
                                  child: Center(
                                    child: Text('Servicios',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ]))
                        ])),
              ]),
        ),
      ),
    );
  }
}

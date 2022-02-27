import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/user_register_provider.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:provider/provider.dart';

class ManageUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Usuarios:    ',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFffffff),
      body: _buildListView(context),
    );
  }
}

ListView _buildListView(BuildContext context) {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (_, index) {
      return ListTile(
        title: Text('Joaquín Asensio Sexy'),
        subtitle: Text('joasexi@ucm.es'),
        trailing: Wrap(
          spacing: 12, // space between two icons
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, 'editProfile');
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Navigator.pushNamed(context, 'editProfile');
              },
            )
          ],
        ),
      );
    },
  );
}

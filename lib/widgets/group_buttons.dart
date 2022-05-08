import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/group_form_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/group_arguments.dart';
import 'package:provider/provider.dart';

class GroupButtons extends StatelessWidget {
  const GroupButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupFormProvider = Provider.of<GroupFormProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: Icon(Icons.add, color: Color(0XFF283593)),
              onPressed: () {
                groupFormProvider.setGroup(groupFormProvider.emptyGroup());
                Navigator.pushNamed(context, 'newGroupPage',
                    arguments: GroupArguments(
                        group: null, userSession: true, isEditing: false));
              }),
          SizedBox(width: 20),
          IconButton(
              icon: Icon(Icons.manage_search, color: Color(0XFF283593)),
              onPressed: () =>
                  {Navigator.pushNamed(context, 'allGroupScreen')}),
        ],
      ),
    );
  }
}

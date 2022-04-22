import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';

class PostEntry {
  final String username;
  final User user;
  final String text;
  final String datetime;

  PostEntry(this.username, this.text, this.user, this.datetime);
}

class AnswerPost extends StatelessWidget {
  final PostEntry entry;

  AnswerPost(this.entry);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 160, 156, 156),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 50.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'seeProfile',
                        arguments: UserArguments(
                            user: entry.user,
                            id: entry.user.id!,
                            userSession: true));
                  },
                  child: Text(entry.username,
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(entry.datetime,
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))),
            child: Text(entry.text),
          ),
        ],
      ),
    );
  }
}

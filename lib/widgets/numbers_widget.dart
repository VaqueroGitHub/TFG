import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/group.dart';
import 'package:flutter_application_tfg/models/post.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/services/group_service.dart';
import 'package:flutter_application_tfg/services/post_service.dart';
import 'package:flutter_application_tfg/services/service_service.dart';
import 'package:get_it/get_it.dart';

class NumbersWidget extends StatelessWidget {
  final String userId;

  const NumbersWidget({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder<List<Service>>(
            future: GetIt.I<ServiceService>().getUserServices(userId),
            initialData: [],
            builder: (context, AsyncSnapshot<List<Service>> snapshot) {
              if (snapshot.hasData) {
                final List<Service> listUser = snapshot.data!;
                return buildButton(
                    context, listUser.length.toString(), 'Servicios');
              }
              return buildButton(context, '0', 'Servicios');
            },
          ),
          buildDivider(),
          FutureBuilder<List<Group>>(
            future: GetIt.I<GroupService>().getUserGroups(userId),
            initialData: [],
            builder: (context, AsyncSnapshot<List<Group>> snapshot) {
              if (snapshot.hasData) {
                final List<Group> listGroups = snapshot.data!;
                return buildButton(
                    context, listGroups.length.toString(), 'Grupos');
              }
              return buildButton(context, '0', 'Grupos');
            },
          ),
          buildDivider(),
          FutureBuilder<List<Post>>(
            future: GetIt.I<PostService>().getUserPosts(userId),
            initialData: [],
            builder: (context, AsyncSnapshot<List<Post>> snapshot) {
              if (snapshot.hasData) {
                final List<Post> listPosts = snapshot.data!;
                return buildButton(
                    context, listPosts.length.toString(), 'Posts');
              }
              return buildButton(context, '0', 'Posts');
            },
          ),
        ],
      );
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
}

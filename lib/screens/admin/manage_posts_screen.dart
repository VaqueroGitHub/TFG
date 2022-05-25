import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/post.dart';
import 'package:flutter_application_tfg/providers/forum_list_provider.dart';
import 'package:flutter_application_tfg/providers/post_form_provider.dart';
import 'package:flutter_application_tfg/providers/post_main_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/post_arguments.dart';
import 'package:flutter_application_tfg/services/post_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ManagePostsScreen extends StatefulWidget {
  @override
  State<ManagePostsScreen> createState() => _ManagePostsScreen();
}

class _ManagePostsScreen extends State<ManagePostsScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Consumer<ForumListProvider>(
        builder: (context, providerData, _) => FutureBuilder<List<Post>>(
            future: providerData.loadAllPostList(),
            builder: (context, AsyncSnapshot<List<Post>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("Loading..."));
              }

              List<Post> postList = snapshot.data!;

              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    return Material(
                      child: ListTile(
                        title: Text(postList[index].title),
                        subtitle: Text(
                            '[${postList[index].forumSection!.title}] ' +
                                (postList[index].answered!
                                    ? 'Respondida'
                                    : 'Sin responder')),
                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                final postFormProvider =
                                    Provider.of<PostFormProvider>(context,
                                        listen: false);
                                final forumListProvider =
                                    Provider.of<ForumListProvider>(context,
                                        listen: false);
                                postFormProvider.setPost(postList[index]);
                                final post = await Navigator.pushNamed(
                                    context, 'newPostPage',
                                    arguments: PostArguments(
                                        forumSection:
                                            postList[index].forumSection!,
                                        userSession: true,
                                        isEditing: true,
                                        post: postList[index]));
                                if (post != null) {
                                  await forumListProvider.loadAllPostList();
                                  forumListProvider.notifyListeners();
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await GetIt.I<PostService>()
                                    .deletePost(postList[index].id!);

                                Navigator.popAndPushNamed(
                                    context, 'adminHomePage',
                                    arguments: 1);
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}

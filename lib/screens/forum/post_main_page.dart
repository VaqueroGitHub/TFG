import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/answer.dart';
import 'package:flutter_application_tfg/models/post.dart';
import 'package:flutter_application_tfg/providers/forum_list_provider.dart';
import 'package:flutter_application_tfg/providers/post_main_provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/post_arguments.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:flutter_application_tfg/services/post_service.dart';
import 'package:flutter_application_tfg/widgets/answer_post.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PostMainPage extends StatefulWidget {
  @override
  _PostMainPageState createState() => _PostMainPageState();
}

class _PostMainPageState extends State<PostMainPage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context)!.settings.arguments as PostArguments;
    final postMainProvider = Provider.of<PostMainProvider>(context);
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    final forumListProvider = Provider.of<ForumListProvider>(context);

    var questionSection = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.01),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              postMainProvider.post.body,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconWithText(Icons.laptop_mac, args.forumSection.title),
                IconWithText(
                  postMainProvider.post.answered!
                      ? Icons.check_circle
                      : Icons.close_rounded,
                  postMainProvider.post.answered!
                      ? "Respondida"
                      : "No respondida",
                ),
                TextButton(
                    onPressed: () => Navigator.pushNamed(context, 'seeProfile',
                        arguments: UserArguments(
                            user: postMainProvider.post.user!,
                            id: postMainProvider.post.user!.id!,
                            userSession: true)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        Text(
                          postMainProvider.post.user!.nick,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    )),
                //IconWithText(Icons.remove_red_eye, "54")
              ],
            ),
          ),
          Divider()
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.13,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          args.post!.idUser == userSessionProvider.user.id
              ? IconButton(
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    final post = await Navigator.pushNamed(
                        context, 'newPostPage',
                        arguments: PostArguments(
                            forumSection: args.forumSection,
                            userSession: true,
                            isEditing: true,
                            post: postMainProvider.post));
                    if (post != null) {
                      postMainProvider.postMain = post as Post;
                      postMainProvider.notifyListeners();
                    }
                  },
                )
              : Container(),
          args.post!.idUser == userSessionProvider.user.id
              ? IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    await GetIt.I<PostService>().deletePost(args.post!.id!);
                    await forumListProvider.loadPostList(args.forumSection.id!);
                    forumListProvider.notifyListeners();
                    Navigator.pop(context);
                  },
                )
              : Container()
        ],
        elevation: 0,
        titleTextStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
        title: Hero(
          tag: postMainProvider.post.id!,
          child: Text(
            postMainProvider.post.title,
            style: Theme.of(context).textTheme.headline3,
            maxLines: 2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            questionSection,
            Expanded(child: _ListAnswers()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  elevation: 10.0,
                  minWidth: 170.0,
                  height: 50.0,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Responder',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, 'newAnswerPage',
                        arguments: PostArguments(
                            post: postMainProvider.post,
                            forumSection: postMainProvider.post.forumSection!,
                            userSession: true,
                            isEditing: false));
                  },
                ),
              ],
            ),
            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );
  }
}

class _ListAnswers extends StatelessWidget {
  const _ListAnswers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PostArguments;
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ForumListProvider>(
        builder: (context, providerData, _) => FutureBuilder<List<Answer>>(
            future: providerData.loadAnswerList(args.post!.id!),
            builder: (context, AsyncSnapshot<List<Answer>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("Loading..."));
              }

              List<Answer> answerList = snapshot.data!;

              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: answerList.length,
                  itemBuilder: (context, index) {
                    return Material(
                      child: AnswerPost(
                        PostEntry(
                          answerList[index].user!.nick,
                          answerList[index].answer,
                          answerList[index].user!,
                          answerList[index].dateTimeToString,
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final IconData iconData;
  final String text;

  IconWithText(this.iconData, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            this.iconData,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(this.text),
          ),
        ],
      ),
    );
  }
}

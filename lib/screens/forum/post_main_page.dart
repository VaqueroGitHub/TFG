import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/answer.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/providers/forum_list_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/post_arguments.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:provider/provider.dart';

class PostMainPage extends StatefulWidget {
  @override
  _PostMainPageState createState() => _PostMainPageState();
}

class _PostMainPageState extends State<PostMainPage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context)!.settings.arguments as PostArguments;

    var questionSection = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.01),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              args.post.body,
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
                  args.post.answered!
                      ? Icons.check_circle
                      : Icons.close_rounded,
                  "Respondida",
                ),
                TextButton(
                    onPressed: () => Navigator.pushNamed(
                        context, 'aboutProfile',
                        arguments: UserArguments(
                            user: args.post.user!,
                            id: args.post.user!.id!,
                            userSession: true)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        Text(
                          args.post.user!.nick,
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
        elevation: 0,
        titleTextStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
        title: Text(
          args.post.title,
          style: Theme.of(context).textTheme.headline3,
          maxLines: 2,
        ),
      ),
      body: Column(
        children: <Widget>[
          questionSection,
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: _ListForumAnswers(),
          )),
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
                          post: args.post,
                          forumSection: args.forumSection,
                          userSession: true));
                },
              ),
            ],
          ),
          SizedBox(height: height * 0.04),
        ],
      ),
    );
  }
}

class ForumPostEntry {
  final String username;
  final User user;
  final String text;

  ForumPostEntry(this.username, this.text, this.user);
}

class _ListForumAnswers extends StatelessWidget {
  const _ListForumAnswers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PostArguments;
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ForumListProvider>(
        builder: (context, providerData, _) => FutureBuilder<List<Answer>>(
            future: providerData.loadAnswerList(args.post.id!),
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
                      child: ForumPost(
                        ForumPostEntry(answerList[index].user!.nick,
                            answerList[index].answer, answerList[index].user!),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}

class ForumPost extends StatelessWidget {
  final ForumPostEntry entry;

  ForumPost(this.entry);

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'aboutProfile',
                              arguments: UserArguments(
                                  user: entry.user,
                                  id: entry.user.id!,
                                  userSession: true));
                        },
                        child: Text(entry.username,
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
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

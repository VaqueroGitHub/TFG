import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/post.dart';
import 'package:flutter_application_tfg/providers/forum_list_provider.dart';
import 'package:flutter_application_tfg/providers/post_main_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/post_arguments.dart';
import 'package:provider/provider.dart';

class MySearchDelegateForums extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar post por titulo';

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () => query = '',
          icon: Icon(Icons.clear),
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Icon(Icons.forum_outlined, color: Colors.black38, size: 130),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final postListProvider =
        Provider.of<ForumListProvider>(context, listen: false);
    postListProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: postListProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Post>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final posts = snapshot.data!;

        return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, int index) => _PostItem(posts[index]));
      },
    );
  }
}

class _PostItem extends StatelessWidget {
  final Post post;

  const _PostItem(this.post);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Hero(tag: post.id!, child: Text(post.title)),
      subtitle: Text(post.body, maxLines: 1, overflow: TextOverflow.ellipsis),
      onTap: () async {
        await Provider.of<PostMainProvider>(context, listen: false)
            .loadPost(post.id!);
        Navigator.pushNamed(context, 'postMainPage',
            arguments: PostArguments(
              forumSection: post.forumSection!,
              post: post,
              userSession: true,
              isEditing: false,
            ));
      },
    );
  }
}

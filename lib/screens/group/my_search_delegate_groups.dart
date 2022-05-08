import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/group.dart';
import 'package:flutter_application_tfg/providers/group_details_provider.dart';
import 'package:flutter_application_tfg/providers/group_list_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/group_arguments.dart';
import 'package:provider/provider.dart';

class MySearchDelegateGroups extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar servicio por asignatura';

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
        child: Icon(Icons.groups_outlined, color: Colors.black38, size: 130),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final groupListProvider =
        Provider.of<GroupListProvider>(context, listen: false);
    groupListProvider.getSuggestionsByQueryAsignatura(query);

    return StreamBuilder(
      stream: groupListProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Group>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final groups = snapshot.data!;

        return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (_, int index) => _GroupItem(groups[index]));
      },
    );
  }
}

class _GroupItem extends StatelessWidget {
  final Group group;

  const _GroupItem(this.group);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Hero(tag: group.id!, child: Text(group.asignatura)),
      subtitle:
          Text(group.description, maxLines: 1, overflow: TextOverflow.ellipsis),
      onTap: () {
        Provider.of<GroupDetailsProvider>(context, listen: false).group = group;
        Navigator.pushNamed(context, 'groupDetails',
            arguments: GroupArguments(
                group: group, userSession: true, isEditing: false));
      },
    );
  }
}

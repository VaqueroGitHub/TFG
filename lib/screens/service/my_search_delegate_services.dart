import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/providers/service_details_provider.dart';
import 'package:flutter_application_tfg/providers/service_list_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/service_arguments.dart';
import 'package:provider/provider.dart';

class MySearchDelegateServices extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar servicio por código';

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
        child: Icon(Icons.design_services_outlined,
            color: Colors.black38, size: 130),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final servicesListProvider =
        Provider.of<ServiceListProvider>(context, listen: false);
    servicesListProvider.getSuggestionsByQueryCode(query);

    return StreamBuilder(
      stream: servicesListProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Service>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final services = snapshot.data!;

        return ListView.builder(
            itemCount: services.length,
            itemBuilder: (_, int index) => _ServiceItem(services[index]));
      },
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final Service service;

  const _ServiceItem(this.service);

  @override
  Widget build(BuildContext context) {
    //movie.heroId = 'search-${ movie.id }';

    return ListTile(
      title: Hero(tag: service.id!, child: Text(service.code)),
      subtitle: Text(service.description,
          maxLines: 1, overflow: TextOverflow.ellipsis),
      onTap: () {
        final serviceDetailsProvider =
            Provider.of<ServiceDetailsProvider>(context, listen: false);
        serviceDetailsProvider.service = service;
        Navigator.pushNamed(context, 'serviceDetails',
            arguments: ServiceArguments(
                service: service, userSession: true, isEditing: false));
      },
    );
  }
}

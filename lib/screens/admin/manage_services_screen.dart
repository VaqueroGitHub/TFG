import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/providers/service_list_provider.dart';
import 'package:provider/provider.dart';

class ManageServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Consumer<ServiceListProvider>(
        builder: (context, providerData, _) => FutureBuilder<List<Service>>(
            future: providerData.loadAllServiceList(),
            builder: (context, AsyncSnapshot<List<Service>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("Loading..."));
              }

              List<Service> serviceList = snapshot.data!;

              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: serviceList.length,
                  itemBuilder: (context, index) {
                    return Material(
                      child: ListTile(
                        title: Text(serviceList[index].code),
                        subtitle: Text('Servicio por: ' +
                            serviceList[index].idMembers.length.toString() ,
                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushNamed(context, 'serviceDetails',
                                    arguments: GroupArguments(
                                        group: serviceList[index],
                                        userSession: false));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await GroupDatabaseService()
                                    .deleteGroup(serviceList[index].id!);

                                Navigator.popAndPushNamed(
                                    context, 'adminHomePage',
                                    arguments: 2);
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

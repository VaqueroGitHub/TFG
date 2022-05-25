import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/providers/service_form_provider.dart';
import 'package:flutter_application_tfg/providers/service_list_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/service_arguments.dart';
import 'package:flutter_application_tfg/services/service_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ManageServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final serviceFormProvider = Provider.of<ServiceFormProvider>(context);
    final serviceListProvider = Provider.of<ServiceListProvider>(context);
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
                            serviceList[index].userOwner!.fullName),
                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                serviceFormProvider
                                    .setService(serviceList[index]);
                                final service = await Navigator.pushNamed(
                                    context, 'newServicePage',
                                    arguments: ServiceArguments(
                                        service: serviceList[index],
                                        userSession: false,
                                        isEditing: true));
                                if (service != null) {
                                  await serviceListProvider
                                      .loadAllServiceList();
                                  serviceListProvider.notifyListeners();
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await GetIt.I<ServiceService>()
                                    .deleteService(serviceList[index].id!);

                                Navigator.popAndPushNamed(
                                    context, 'adminHomePage',
                                    arguments: 3);
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

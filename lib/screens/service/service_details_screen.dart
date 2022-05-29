// ignore_for_file: file_names
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/models/service_message.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/providers/service_details_provider.dart';
import 'package:flutter_application_tfg/providers/service_form_provider.dart';
import 'package:flutter_application_tfg/providers/service_list_provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/service_arguments.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:flutter_application_tfg/services/service_service.dart';
import 'package:flutter_application_tfg/widgets/answer_post.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ServiceArguments;
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    final serviceDetailsProvider = Provider.of<ServiceDetailsProvider>(context);
    final serviceFormProvider = Provider.of<ServiceFormProvider>(context);
    final serviceListProvider = Provider.of<ServiceListProvider>(context);

    return Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFffffff),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () async {
                Navigator.pop(context);
              }),
          title: Text(
            'Servicio',
            style: Theme.of(context).textTheme.headline3,
          ),
          actions: [
            serviceDetailsProvider.service!.idOwnerUser ==
                    userSessionProvider.user.id
                ? IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      serviceFormProvider
                          .setService(serviceDetailsProvider.service!);
                      final service = await Navigator.pushNamed(
                          context, 'newServicePage',
                          arguments: ServiceArguments(
                              service: serviceDetailsProvider.service!,
                              userSession: true,
                              isEditing: true));
                      if (service != null) {
                        serviceDetailsProvider.service = service as Service;
                        serviceDetailsProvider.notifyListeners();
                      }
                    },
                  )
                : Container(),
            serviceDetailsProvider.service!.idOwnerUser ==
                    userSessionProvider.user.id
                ? IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      await GetIt.I<ServiceService>()
                          .deleteService(serviceDetailsProvider.service!.id!);
                      await serviceListProvider
                          .loadUserServiceList(userSessionProvider.user.id!);
                      serviceListProvider.notifyListeners();
                      await Future.delayed(Duration(milliseconds: 150),
                          () => Navigator.pop(context));
                    },
                  )
                : Container()
          ],
        ),
        backgroundColor: Color(0xFFffffff),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            GroupNumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(context),
            const SizedBox(height: 48),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _InfoLinks(),
                userSessionProvider.user.id ==
                            serviceDetailsProvider.service!.idOwnerUser ||
                        serviceDetailsProvider.service!.idCustomerUser ==
                            userSessionProvider.user.id ||
                        !serviceDetailsProvider.service!.idCustomerUser.isEmpty
                    ? Container()
                    : MaterialButton(
                        elevation: 10.0,
                        minWidth: 200.0,
                        height: 50.0,
                        color: userSessionProvider.user.id ==
                                    serviceDetailsProvider
                                        .service!.idOwnerUser ||
                                serviceDetailsProvider
                                        .service!.idCustomerUser ==
                                    userSessionProvider.user.id ||
                                !serviceDetailsProvider
                                    .service!.idCustomerUser.isEmpty
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Obtener',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {
                          await GetIt.I<ServiceService>().obtainService(
                              serviceDetailsProvider.service!,
                              userSessionProvider.user.id!);

                          await serviceListProvider.loadUserServiceList(
                              userSessionProvider.user.id!);
                          await serviceListProvider.loadAllServiceList();
                          serviceListProvider.notifyListeners();
                          args.userSession
                              ? Navigator.pushReplacementNamed(
                                  context, 'servicesMainPage')
                              : Navigator.popAndPushNamed(
                                  context, 'adminHomePage',
                                  arguments: 3);
                        },
                      ),
                SizedBox(height: 20),
                serviceDetailsProvider.service!.idOwnerUser ==
                            userSessionProvider.user.id! ||
                        serviceDetailsProvider.service!.idCustomerUser ==
                            userSessionProvider.user.id!
                    ? _ChatCardWidget()
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildName(BuildContext context, User user) => Column(
        children: [
          Text(
            user.nick,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(BuildContext context) {
    final serviceDetailsProvider = Provider.of<ServiceDetailsProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Descripcion del servicio ofertado 👨🏻‍🎓',
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 16),
          Text(
            serviceDetailsProvider.service!.description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

void _launchURL(_url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}

class _ChatCardWidget extends StatelessWidget {
  const _ChatCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceDetailsProvider = Provider.of<ServiceDetailsProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTileCard(
        leading: Icon(Icons.chat),
        title: Text('Chat!'),
        //subtitle: Text('I expand!'),
        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          TextButton(
              onPressed: () => Navigator.pushNamed(context, 'newServiceMessage',
                  arguments: ServiceArguments(
                      service: serviceDetailsProvider.service!,
                      userSession: true,
                      isEditing: false)),
              child: Text("Nuevo mensaje")),
          _ListChatService(),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[],
          ),
        ],
      ),
    );
  }
}

class _ListChatService extends StatelessWidget {
  const _ListChatService({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceDetailsProvider = Provider.of<ServiceDetailsProvider>(context);

    return Consumer<ServiceListProvider>(
        builder: (context, serviceListProvider, child) {
      return FutureBuilder<List<ServiceMessage>>(
          future: serviceListProvider
              .loadMessagesServiceList(serviceDetailsProvider.service!.id!),
          builder: (context, AsyncSnapshot<List<ServiceMessage>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text("Loading..."));
            }
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: serviceListProvider.listMessage.length,
                itemBuilder: (context, index) {
                  return Material(
                    child: AnswerPost(
                      PostEntry(
                          serviceListProvider.listMessage[index].user!.nick,
                          serviceListProvider.listMessage[index].message,
                          serviceListProvider.listMessage[index].user!,
                          serviceListProvider
                              .listMessage[index].dateTimeToString),
                    ),
                  );
                });
          });
    });
  }
}

class _InfoLinks extends StatelessWidget {
  const _InfoLinks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceDetailsProvider = Provider.of<ServiceDetailsProvider>(context);
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //     '⭐ Coste del servicio: ${serviceDetailsProvider.service!.nCoins} coins'),
        SizedBox(height: 10),
        !serviceDetailsProvider.service!.conference.isEmpty &&
                (serviceDetailsProvider.service!.idOwnerUser ==
                        userSessionProvider.user.id! ||
                    serviceDetailsProvider.service!.idCustomerUser ==
                        userSessionProvider.user.id!)
            ? TextButton(
                child: Text("📹 Conference url "),
                onPressed: () =>
                    _launchURL(serviceDetailsProvider.service!.conference),
              )
            : Container(),
        SizedBox(height: 20),
      ],
    );
  }
}

class GroupNumbersWidget extends StatelessWidget {
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text,
          String? onPressedRoute, dynamic? onPressedArgs) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: onPressedRoute != null
            ? () => Navigator.pushNamed(context, onPressedRoute,
                arguments: onPressedArgs!)
            : null,
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

  @override
  Widget build(BuildContext context) {
    final serviceDetailsProvider = Provider.of<ServiceDetailsProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // buildButton(context, serviceDetailsProvider.service!.nCoins.toString(),
        //     'Coste', null, null),
        serviceDetailsProvider.service!.userCustomer != null
            ? buildButton(
                context,
                serviceDetailsProvider.service!.userCustomer!.nick,
                'Beneficiario',
                'seeProfile',
                UserArguments(
                    user: serviceDetailsProvider.service!.userCustomer!,
                    id: serviceDetailsProvider.service!.userCustomer!.id!,
                    userSession: true))
            : Container(),
        buildDivider(),
        Hero(
          tag: serviceDetailsProvider.service!.id!,
          child: buildButton(context, serviceDetailsProvider.service!.code,
              'Codigo', null, null),
        ),
        buildDivider(),
        buildButton(
            context,
            serviceDetailsProvider.service!.userOwner!.nick,
            'Propietario',
            'seeProfile',
            UserArguments(
                user: serviceDetailsProvider.service!.userOwner!,
                id: serviceDetailsProvider.service!.userOwner!.id!,
                userSession: true)),
        buildDivider(),
      ],
    );
  }
}

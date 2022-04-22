import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/providers/service_list_provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/service_arguments.dart';
import 'package:flutter_application_tfg/screen_arguments/user_arguments.dart';
import 'package:flutter_application_tfg/widgets/nav_bar.dart';
import 'package:flutter_application_tfg/widgets/service_buttons.dart';
import 'package:provider/provider.dart';

class ServiceMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userSessionProvider = Provider.of<UserSessionProvider>(context);
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () => Navigator.pushReplacementNamed(
            context,
            'aboutProfile',
            arguments: UserArguments(
                user: userSessionProvider.user,
                id: userSessionProvider.user.id!,
                userSession: true),
          ),
          child: IconButton(
            onPressed: () => Navigator.pushReplacementNamed(
              context,
              'aboutProfile',
              arguments: UserArguments(
                  user: userSessionProvider.user,
                  id: userSessionProvider.user.id!,
                  userSession: true),
            ),
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color(0xFFffffff),
        bottomNavigationBar: navBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.04),
                Text(
                  'Servicios',
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.06),
                ServiceButtons(),
                _ServiceList(
                    height: height, userSessionProvider: userSessionProvider),
              ],
            ),
          ),
        ));
  }
}

class _ServiceList extends StatelessWidget {
  const _ServiceList({
    Key? key,
    required this.height,
    required this.userSessionProvider,
  }) : super(key: key);

  final double height;
  final UserSessionProvider userSessionProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.64,
      child: Consumer<ServiceListProvider>(
          builder: (context, providerData, _) => FutureBuilder<List<Service>>(
              future: providerData
                  .loadUserServiceList(userSessionProvider.user.id!),
              builder: (context, AsyncSnapshot<List<Service>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("Loading..."));
                }

                List<Service> groupList = snapshot.data!;

                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: groupList.length,
                    itemBuilder: (context, index) {
                      return Material(
                        child: _ServiceLabel(
                          etiqueta: groupList[index].code,
                          text: groupList[index].description,
                          press: () => {
                            Navigator.pushNamed(context, 'serviceDetails',
                                arguments: ServiceArguments(
                                    service: groupList[index],
                                    userSession: true))
                          },
                        ),
                      );
                    });
              })),
    );
  }
}

class _ServiceLabel extends StatelessWidget {
  const _ServiceLabel({
    Key? key,
    required this.text,
    required this.etiqueta,
    this.press,
  }) : super(key: key);

  final String text;
  final String etiqueta;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Text(
              etiqueta,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(width: 20),
            Expanded(
                child:
                    Text(text, style: Theme.of(context).textTheme.bodyText2)),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0XFF283593),
            ),
          ],
        ),
      ),
    );
  }
}

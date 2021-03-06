// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/service.dart';
import 'package:flutter_application_tfg/providers/service_details_provider.dart';
import 'package:flutter_application_tfg/providers/service_list_provider.dart';
import 'package:flutter_application_tfg/screen_arguments/service_arguments.dart';
import 'package:flutter_application_tfg/screens/service/my_search_delegate_services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';

class AllServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final userSessionProvider = Provider.of<UserSessionProvider>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFffffff),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context)),
          actions: [
            IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: MySearchDelegateServices()),
              icon: Icon(Icons.search),
              color: Colors.black,
            )
          ],
          title: Text(
            'Todos los servicios',
            style: Theme.of(context).textTheme.headline4,
          )),
      backgroundColor: Color(0xFFffffff),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: height * 0.8,
              child: Consumer<ServiceListProvider>(
                  builder: (context, providerData, _) => FutureBuilder<
                          List<Service>>(
                      future: providerData.loadAllServiceList(),
                      builder:
                          (context, AsyncSnapshot<List<Service>> snapshot) {
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
                                child: Hero(
                                  tag: serviceList[index].id!,
                                  child: _ServiceLabel(
                                    etiqueta: serviceList[index].code,
                                    text: serviceList[index].description,
                                    press: () {
                                      final serviceDetailsProvider =
                                          Provider.of<ServiceDetailsProvider>(
                                              context,
                                              listen: false);
                                      serviceDetailsProvider.service =
                                          serviceList[index];
                                      Navigator.pushNamed(
                                          context, 'serviceDetails',
                                          arguments: ServiceArguments(
                                              service: serviceList[index],
                                              userSession: true,
                                              isEditing: false));
                                    },
                                  ),
                                ),
                              );
                            });
                      })),
            ),
          ],
        ),
      ),
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
                child: Text(text,
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis)),
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

class _ProfileMenu extends StatelessWidget {
  const _ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconButton icon;
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
            icon,
            SizedBox(width: 20),
            Expanded(
                child: Text(text, style: TextStyle(color: Color(0XFF283593)))),
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

class _ProfilePic extends StatelessWidget {
  const _ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/imgs/profile.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

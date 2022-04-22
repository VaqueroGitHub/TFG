import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class navBar extends StatelessWidget {
  const navBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    return NavigationBarTheme(
        data: const NavigationBarThemeData(indicatorColor: Colors.transparent),
        child: NavigationBar(
          selectedIndex: uiProvider.currentNavigatorIndex,
          onDestinationSelected: (index) {
            uiProvider.currentNavigatorIndex = index;
            switch (index) {
              case 0:
                Navigator.pushNamedAndRemoveUntil(context, 'servicesMainPage',
                    (Route<dynamic> route) => false);
                break;
              case 1:
                Navigator.pushNamedAndRemoveUntil(
                    context, 'groupsMainPage', (Route<dynamic> route) => false);
                break;
              case 2:
                Navigator.pushNamedAndRemoveUntil(
                    context, 'forumMainPage', (Route<dynamic> route) => false);
                break;
              case 3:
                Navigator.pushNamedAndRemoveUntil(
                    context, 'profile', (Route<dynamic> route) => false);
                break;
              default:
                Navigator.pushNamedAndRemoveUntil(
                    context, 'profile', (Route<dynamic> route) => false);
            }
          },
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          backgroundColor: Colors.transparent,
          destinations: const [
            NavigationDestination(
                selectedIcon: Icon(Icons.design_services),
                icon: Icon(Icons.design_services_outlined),
                label: 'Servicios'),
            NavigationDestination(
                selectedIcon: Icon(Icons.groups),
                icon: Icon(Icons.groups_outlined),
                label: 'Grupos'),
            NavigationDestination(
                selectedIcon: Icon(Icons.forum),
                icon: Icon(Icons.forum_outlined),
                label: 'Foros'),
            NavigationDestination(
                selectedIcon: Icon(Icons.settings),
                icon: Icon(Icons.settings_outlined),
                label: 'Perfil'),
          ],
        ));
  }
}

import 'package:flutter/material.dart';

class navBar extends StatelessWidget {
  const navBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
        data: const NavigationBarThemeData(indicatorColor: Colors.transparent),
        child: NavigationBar(
          selectedIndex: 2,
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
                selectedIcon: Icon(Icons.insert_emoticon_rounded),
                icon: Icon(Icons.insert_emoticon_outlined),
                label: 'Perfil'),
          ],
        ));
  }
}

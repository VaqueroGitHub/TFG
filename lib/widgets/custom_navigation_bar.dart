import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return BottomNavigationBar(
      currentIndex: uiProvider.currentNavigatorIndex,
      elevation: 0,
      onTap: (val) {
        uiProvider.currentNavigatorIndex = val;
      },
      backgroundColor: Colors.transparent,
      fixedColor: Colors.black,
      selectedLabelStyle: TextStyle(color: Colors.black),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.design_services_outlined, color: Colors.black),
            label: 'Servicios'),
        BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined, color: Colors.black),
            label: 'Grupos'),
        BottomNavigationBarItem(
            icon: Icon(Icons.forum_outlined, color: Colors.black),
            label: 'Foros'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, color: Colors.black),
            label: 'Perfil'),
      ],
    );
  }
}

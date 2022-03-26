import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int currentBottomNavigatorIndex = 0;

  int get currentNavigatorIndex {
    return currentBottomNavigatorIndex;
  }

  void set currentNavigatorIndex(int index) {
    currentBottomNavigatorIndex = index;
  }
}

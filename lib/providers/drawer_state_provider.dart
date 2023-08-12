import 'package:fablearner_app/utils/helper.dart';
import 'package:flutter/material.dart';

class DrawerStateProvider extends ChangeNotifier {
  bool _isDrawerOpen = false;
  bool get isDrawerOpen => _isDrawerOpen;

  void setDrawerState(bool isOpen) {
    _isDrawerOpen = isOpen;
    printIfDebug("DrawerStateProvider: drawer is open => $_isDrawerOpen");
    notifyListeners();
  }
}

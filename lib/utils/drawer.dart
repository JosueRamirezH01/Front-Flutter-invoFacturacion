import 'package:flutter/material.dart';

class DrawerState extends ChangeNotifier {
  int _selectOption = -1;

  int get selectOption => _selectOption;

  void updateSelectOption(int index) {
    _selectOption = index;
    notifyListeners();
  }

}
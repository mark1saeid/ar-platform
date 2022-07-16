import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/features/home/view/main_menu.dart';

class RouterCenter extends ChangeNotifier {
     Widget centerScreen = MainMenu();

  changeCenterScreen(Widget centerScreen) {
    this.centerScreen = centerScreen;
    notifyListeners();
  }
}
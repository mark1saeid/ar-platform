import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/features/chat/general_widget/income_call_widget.dart';
import 'package:ratering_gen_zero/features/home/view/notfications_menu.dart';

class RouterLeft extends ChangeNotifier {
 // Widget leftScreen = NotficationsMenu();
  Widget leftScreen = IncomeCallWidget();

  changeLeftScreen(Widget leftScreen) {
    this.leftScreen = leftScreen;
    notifyListeners();
  }
}

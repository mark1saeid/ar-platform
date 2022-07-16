import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/features/acitve_user/view/active_userr_page/active_user_page.dart';



class RouterRight extends ChangeNotifier {
  Widget rightScreen = ActiveUserScreen();

  changeRightScreen(Widget rightScreen) {
    this.rightScreen = rightScreen;
    notifyListeners();
  }
}

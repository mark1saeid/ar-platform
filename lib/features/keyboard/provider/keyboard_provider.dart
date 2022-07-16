import 'package:flutter/material.dart';

class KeyboardProvider extends ChangeNotifier {
  bool keyboardState = false;
  String text = "";

  setText(String txt) {
    text = txt;
    notifyListeners();
  }

  addKey(String key) {
    text += key;
    print(text);
    notifyListeners();
  }

  backDelete() {
    if (text != null && text.length > 0) {
      text = text.substring(0, text.length - 1);
    }
    notifyListeners();
  }

  clear() {
    text = "";
    notifyListeners();
  }

  changeKeyboardState() {
    keyboardState = !keyboardState;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  bool gameState = false;

  setGameState() {
    gameState = !gameState;
    notifyListeners();
  }
}

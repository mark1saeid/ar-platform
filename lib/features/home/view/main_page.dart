import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/core/hands/Camera_hands_service.dart';
import 'package:ratering_gen_zero/features/game/game_screen.dart';
import 'package:ratering_gen_zero/features/home/general_widget/panorama_widget.dart';
import 'package:ratering_gen_zero/features/home/provider/game_provider.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'MyHomePage';

  MainScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CameraHandsWidget(),
          PanoramaWidget(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/core/router/route_center.dart';
import 'package:ratering_gen_zero/features/chat/view/main_page/chat_page.dart';
import 'package:ratering_gen_zero/list.dart';

import '../../game/game_screen.dart';

class MainMenu extends StatefulWidget {
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Menu",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        SizedBox(
          height: 320,
          width: 280,
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              ...menu_item.map((e) => Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(e["image"])),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.white,
                          ),
                        ),
                        onTapDown: (x) {
                          // log("metting down ${x.globalPosition}");
                        },
                        onTapUp: (x) {
                          // log("metting up ${x.globalPosition}");
                        },
                        onTap: () {
                          if (e["id"] == "Chat") {
                            //  log("Chat");
                            Provider.of<RouterCenter>(
                              context,
                              listen: false,
                            ).changeCenterScreen(ChatPage());
                          }
                          if (e["id"] == "Basketball") {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (ctx) => GameScreen()));
                          }
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        e["text"],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/features/chat/view/main_page/chat_page.dart';

class CircleMenu extends StatelessWidget {
  const CircleMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 380,
        width: 280,
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            //  color: Colors.black38,
            borderRadius: BorderRadius.circular(20)),
        child: ChatPage());
  }
}

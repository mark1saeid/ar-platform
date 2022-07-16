import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/keyboard_provider.dart';

class KeyboardItem extends StatelessWidget {
 final String text;
  const KeyboardItem({Key key,this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        switch(text){
          case "back":
            Provider.of<KeyboardProvider>(
              context,
              listen: false,
            ).backDelete();
            break;
          case "enter":
            Provider.of<KeyboardProvider>(
              context,
              listen: false,
            ).addKey("\n");
            break;
          case "clear":
            Provider.of<KeyboardProvider>(
              context,
              listen: false,
            ).clear();
            break;
          default:
            Provider.of<KeyboardProvider>(
              context,
              listen: false,
            ).addKey(text);
            break;

        }
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(child: Text(text,style: TextStyle(color: Colors.black38),)),
      ),
    );
  }
}

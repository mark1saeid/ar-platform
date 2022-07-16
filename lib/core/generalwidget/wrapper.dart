import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
 final Widget widget;

  const Wrapper({Key key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.4,vertical:  MediaQuery.of(context).size.height * 0.1),
          child: Icon(Icons.linear_scale_rounded)
    ),
        ),
      widget
      ],
    );
  }
}

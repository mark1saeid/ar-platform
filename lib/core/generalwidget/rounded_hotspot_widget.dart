import 'package:flutter/material.dart';

class RoundedHotSpotWidget extends StatelessWidget {
  Widget widget;
  RoundedHotSpotWidget({this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
     // padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Center(child: widget),
    );
  }
}

import 'package:flutter/material.dart';

class HotSpotWidget extends StatelessWidget {
  Widget widget;
  HotSpotWidget({this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Center(child: widget),
    );
  }
}

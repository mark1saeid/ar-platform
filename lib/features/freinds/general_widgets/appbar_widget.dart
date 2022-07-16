import 'package:flutter/material.dart';

AppBar friendsAppbarWidget({
  String text,
  Function backFun,
}) {
  return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          InkWell(
            onTap: () {
              return backFun();
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ));
}

import 'package:flutter/material.dart';

Widget buildEditProfileButton({
  String text,
  Color backgroundColor,
  Color textColor,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            letterSpacing: 2.2,
            color: textColor,
          ),
        ),
      ),
    ),
  );
}

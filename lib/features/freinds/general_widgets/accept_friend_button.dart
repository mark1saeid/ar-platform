import 'package:flutter/material.dart';

Widget submitButtonWidget({
  @required String text,
  @required Function onTap,
  Color buttonColor,
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
    
      child: Container(
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(text,
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 7,
        ),
      ),
    ),
  );
}

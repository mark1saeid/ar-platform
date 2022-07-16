import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget buildBigContainer({String text, String text2, BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      width: double.infinity,
      height: (MediaQuery.of(context).size.height *0.3),
      decoration: BoxDecoration(
          color: HexColor('#1a2228'), borderRadius: BorderRadius.circular(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.white),
          ),
          SizedBox(height:7,),
          Text(
            text2,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget buildNavigationContainer({String text, String text2, BuildContext context,IconData icon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      padding: EdgeInsets.all(15),
      height: 85,
      decoration: BoxDecoration(
        color: HexColor('#1a2228'),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: HexColor('#414654'),
            child: Icon(icon,color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  text2,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

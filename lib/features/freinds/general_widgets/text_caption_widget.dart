import 'package:flutter/material.dart';

Widget textCaptionWidget({
  String id,
}) {
  
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Row(
      children: [
        Text(
          'Your username is ',
        ),
        Text(
          id,
          style: TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
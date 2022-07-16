import 'package:flutter/material.dart';

buildProfilePicWidget({BuildContext context, DecorationImage image}) {
  return Container(
    width: 130,
    height: 130,
    decoration: BoxDecoration(
      border: Border.all(
        width: 4,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      boxShadow: [
        BoxShadow(
            spreadRadius: 2,
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 10))
      ],
      shape: BoxShape.circle,
      image: image,
    ),
  );
}

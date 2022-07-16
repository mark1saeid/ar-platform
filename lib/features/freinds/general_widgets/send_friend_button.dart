import 'package:flutter/material.dart';

Widget sendFriendRequestButton({Color color,Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Center(
        child: Text(
          'Send Friend Request',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

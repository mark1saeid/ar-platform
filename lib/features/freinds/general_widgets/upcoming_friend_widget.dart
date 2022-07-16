import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'accept_friend_button.dart';

Widget upcomingFriendWidget({
  String image,
  String userName,
  Function confirmFun,
  Function deleteFun,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 35,
              backgroundImage: image != null
                  ? CachedNetworkImageProvider('$image')
                  : CachedNetworkImageProvider(
                      'https://www.oseyo.co.uk/wp-content/uploads/2020/05/empty-profile-picture-png-2-2.png',
                    ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$userName",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      submitButtonWidget(
                        text: 'Confirm',
                        onTap: confirmFun,
                        buttonColor: Colors.black,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      submitButtonWidget(
                        text: 'Delete',
                        onTap: deleteFun,
                        buttonColor: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 7),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
      ],
    ),
  );
}

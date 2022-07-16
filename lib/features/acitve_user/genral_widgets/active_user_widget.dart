import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget activeUserWidget({
  String text,
  String image,
  bool isActive,
  Function callFunction,

  Function createMessageFunction,context
}) {
  return Container(
    padding:
    const EdgeInsets.all(5),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[
              CircleAvatar(
                radius: 18,

                backgroundImage: image == ''
                    ? CachedNetworkImageProvider(
                    'https://www.oseyo.co.uk/wp-content/uploads/2020/05/empty-profile-picture-png-2-2.png')
                    : CachedNetworkImageProvider(image),
              ),
               SizedBox(
                width: MediaQuery.of(context).size.width*0.02,
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        text??'',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                  onTap: createMessageFunction,
                  child: Icon(Icons.message, color: Colors.white)),
              SizedBox(width: 10),
              GestureDetector(
                  onTap: callFunction,
                  child: Icon(Icons.call, color: Colors.white)),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 5,
                backgroundColor: isActive ? Colors.green : Colors.grey[700],
              ),
            ],
          ),
        ),
            ],
          ),
        );
}

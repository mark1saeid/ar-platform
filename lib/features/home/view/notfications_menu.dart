import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/core/generalwidget/rounded_hotspot_widget.dart';
import 'package:ratering_gen_zero/list.dart';

class NotficationsMenu extends StatelessWidget {
  const NotficationsMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      width: 280,
      child: ListView(
        children: [
          ...notification.map((e) => Column(
                children: [
                  RoundedHotSpotWidget(
                    widget: ListTile(
                      leading: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(e["image"])),
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)),
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        e["content"],
                        style: TextStyle(fontSize: 15,color: Colors.grey.shade500),
                      ),
                      title: Text(
                        e["name"],
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ))
        ],
      ),
    );
  }
}

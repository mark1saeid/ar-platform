import 'dart:convert';

import 'package:flutter/cupertino.dart';

class ChatUsers {
  String text;
  String secondaryText;
  String image;
  String time;
  bool isActive;

  ChatUsers({
    this.text,
    this.secondaryText,
    this.image,
    this.time,
    this.isActive,
  });

 

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'secondaryText': secondaryText,
      'image': image,
      'time': time,
      'isActive': isActive,
    };
  }

  factory ChatUsers.fromMap(Map<String, dynamic> map) {
    return ChatUsers(
      text: map['text'] ?? '',
      secondaryText: map['secondaryText'] ?? '',
      image: map['image'] ?? '',
      time: map['time'] ?? '',
      isActive: map['isActive'] ?? false,
    );
  }

  
}

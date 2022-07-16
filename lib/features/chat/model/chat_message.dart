import 'dart:convert';

import 'package:ratering_gen_zero/features/chat/view/chat_details_page/chat_detail_page.dart';


class ChatMessage {
  String message;
  String senderID;
  String time;
  ChatMessage({this.message, this.senderID , this.time});

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'senderID': senderID ,
      'time': time,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> map) {
    return ChatMessage(
      message: map['message'] ?? '',
      senderID: map['senderID'] ?? '',
      time: map['time'] ?? '',
    );
  }

  
}

import 'dart:convert';

import 'package:ratering_gen_zero/features/chat/model/chat_message.dart';

import '../../auth/model/user_model.dart';

class ChatRoom {
  UserModel otherUser;
  List<ChatMessage> chatMessages;
  String chatRoomID;

  ChatRoom({
     this.otherUser,
     this.chatMessages,
     this.chatRoomID,
  });

 


}

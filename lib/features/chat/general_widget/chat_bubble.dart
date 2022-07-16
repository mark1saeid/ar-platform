import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';
import 'package:ratering_gen_zero/features/chat/view/chat_details_page/chat_detail_page.dart';
import 'package:ratering_gen_zero/features/chat/model/chat_message.dart';
import 'package:ratering_gen_zero/features/freinds/constant.dart';

class ChatBubble extends StatefulWidget {
  ChatMessage chatMessage;

  ChatBubble({this.chatMessage});

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
 

  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: 12,
      ),
      child: Align(
        alignment: (widget.chatMessage.senderID == myId
            ? Alignment.topRight
            : Alignment.topLeft),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft:
                  Radius.circular(widget.chatMessage.senderID == myId ? 30 : 0),
              bottomLeft:
                  Radius.circular(widget.chatMessage.senderID == myId ? 30 : 0),
              bottomRight:
                  Radius.circular(widget.chatMessage.senderID == myId ? 0 : 30),
              topRight:
                  Radius.circular(widget.chatMessage.senderID == myId ? 0 : 30),
            ),
            color: (widget.chatMessage.senderID == myId
                ? Colors.black.withOpacity(0.3)
                : Colors.white),
          ),
          padding: const EdgeInsets.all(12),
          child: Text(
            widget.chatMessage.message,
            style: TextStyle(
                color: widget.chatMessage.senderID == myId
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/core/router/route_center.dart';
import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import 'package:ratering_gen_zero/features/auth/services/local_service.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';
import 'package:ratering_gen_zero/features/chat/view/chat_details_page/chat_detail_page.dart';

class ChatUsersList extends StatelessWidget {
  String username;
  String secondaryText;
  String profilePic;
  String time;
  String chatRoomId;
  bool isMessageRead;
  final UserModel userModel;

  ChatUsersList({
    this.username,
    this.secondaryText,
    this.profilePic,
    this.time,
   this.chatRoomId,
    this.isMessageRead,
  @required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return ChatUserList(
        username: username,
        secondaryText: secondaryText,
        profilePic: profilePic,
        time: time,
        chatRoomId :chatRoomId,
        isMessageRead: isMessageRead,
        userModel: userModel); //);
  }
}

class ChatUserList extends StatefulWidget {
  String username;
  String secondaryText;
  String profilePic;
  String time;
  String chatRoomId;
  bool isMessageRead;
  final UserModel userModel;
  //final String chatWithUsername, name;
  

  ChatUserList(
      {this.username,
      this.secondaryText,
      this.profilePic,
      this.time,
      this.chatRoomId,
      this.isMessageRead,
      @required this.userModel});

  @override
  _ChatUserListState createState() => _ChatUserListState();
}

class _ChatUserListState extends State<ChatUserList> {
   

   
  
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        // Todo need ItChat Room from him 
       
        

       
      //  chatRoomId ;

        

        Provider.of<RouterCenter>(
          context,
          listen: false,
        ).changeCenterScreen(ChatDetailPage(userModel: widget.userModel,
        chatRoomId:widget.chatRoomId));

      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.profilePic),
                    maxRadius: 25,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.username ?? "",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.secondaryText,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  color: widget.isMessageRead
                      ? Colors.green
                      : Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}

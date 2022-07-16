import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/core/generalwidget/loader_widget.dart';
import 'package:ratering_gen_zero/core/router/route_center.dart';
import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';
import 'package:ratering_gen_zero/features/chat/general_widget/chat.dart';
import 'package:ratering_gen_zero/features/chat/model/chat_message.dart';
import 'package:ratering_gen_zero/features/chat/model/chat_room.dart';
import 'package:ratering_gen_zero/features/home/view/main_menu.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _searchController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchKey = GlobalKey<FormState>();
  bool _isSearching = false;
  //Stream usersStream;

  Future<List<dynamic>> getAllUsers() async {
    UserService userService = UserService();
    List<dynamic> _users = await userService.getAllUsers();
    return _users;
  }

  Future<List<ChatRoom>> getAllUserschat() async {
    UserService userService = UserService();
    List<ChatRoom> _chatRoom = await userService.getChatRooms();
    
    
    return _chatRoom;
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    getAllUserschat();
    getAllUsers();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: FutureBuilder<List<ChatRoom>>(
            future: getAllUserschat(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LoaderWidget(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }

              if (snapshot.hasData) {
                List<ChatRoom> data = snapshot.data;
                // ! UserModel && ChatRoomID && Message

                List<String> _chatRoomIDs = data.asMap().map((key, value) => MapEntry(key, value.chatRoomID)).values.toList();
               
                List<UserModel> userModel = data
                    .asMap()
                    .map((index, chatRoom) {
                      return MapEntry(
                          index,
                          UserModel(
                            username: chatRoom.otherUser.username,
                            uId: chatRoom.otherUser.uId,
                            name: chatRoom.otherUser.name,
                            email: chatRoom.otherUser.email,
                            profilePic: chatRoom.otherUser.profilePic,
                          ));
                    })
                    .values
                    .toList();

                 

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Provider.of<RouterCenter>(
                            context,
                            listen: false,
                          ).changeCenterScreen(MainMenu());
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              "Chats",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 55,
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child:
                            // Todo : Search
                            TextField(
                          key: _searchKey,
                          //readOnly: true,
                          // showCursor: true,
                          onChanged: (value) {},
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Search...",
                            hintStyle: TextStyle(
                                fontSize: 15, color: Colors.grey.shade400),
                            prefixIcon: GestureDetector(
                              onTap: () {
                                if (_searchController.text != null ||
                                    _searchController.text.trim() != "") {
                                  // onSearchBtnClick();
                                }
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.grey.shade400,
                                size: 20,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            //grey.shade100,
                            contentPadding: const EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100)),
                          ),
                        ),
                      ),
                      ListView.builder(
                        itemCount: userModel.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index)  {
                          List<ChatMessage> list = [
                            ChatMessage(
                              message: "Hello",
                              senderID: "SenderID",
                             
                            ),
                          ];
                          UserService().getChatMessages(
                                _chatRoomIDs[index]).then((value) {
                                  list = value.toList();
                                });
                          return ChatUsersList(
                            chatRoomId: _chatRoomIDs[index],
                            username: userModel[index].username,
                            secondaryText: list.last.message,
                            profilePic: userModel[index].profilePic,
                            time: "",
                            isMessageRead:
                                (index == 0 || index == 3) ? true : false,
                            userModel: userModel[index],
                          );
                        },
                      ),
                    ],
                  ),
                );
              }

              return Container();
            }));
  }
}

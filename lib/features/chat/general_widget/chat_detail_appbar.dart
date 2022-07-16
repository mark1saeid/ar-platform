import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/core/router/route_center.dart';
import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import 'package:ratering_gen_zero/features/chat/view/chat_details_page/chat_detail_page.dart';
import 'package:ratering_gen_zero/features/chat/view/main_page/chat_page.dart';


class ChatDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final UserModel userModel;

  const ChatDetailAppBar({Key key, @required this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent, //color edited by
      // backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        top: false, // edited by ahmed
        child: Container(
          padding: const EdgeInsets.only(
            top: 10,
            right: 5,
          ),
          child: Row(
            children: <Widget>[
              //  edited by ahmed
              IconButton(
                onPressed: () {
                 //!  Router  
                 Provider.of<RouterCenter>(
          context,
          listen: false,
        ).changeCenterScreen(ChatPage());
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),

              const SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(userModel.profilePic),
                maxRadius: 20,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      userModel.username,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white, // edited by ahmed
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Online",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

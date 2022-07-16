import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/core/generalwidget/loader_widget.dart';
import 'package:ratering_gen_zero/core/router/route_center.dart';
import 'package:ratering_gen_zero/core/router/route_right.dart';
import 'package:ratering_gen_zero/core/shared_preferences.dart';
import 'package:ratering_gen_zero/core/utils/call_utils.dart';
import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';
import 'package:ratering_gen_zero/features/chat/view/voice_call_page/voice_call_page.dart';
import '../../../freinds/constant.dart';
import '../../genral_widgets/active_user_search.dart';
import '../../genral_widgets/active_user_widget.dart';
import '../../sevices/active_user_services.dart';

class ActiveUserScreen extends StatefulWidget {
  static const String id = 'ActiveUserScreen';

  @override
  State<ActiveUserScreen> createState() => _ActiveUserScreenState();
}

class _ActiveUserScreenState extends State<ActiveUserScreen> {
  String userImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            buildActiveUserSearchBox(context: context),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(myId)
                        .collection('friends')
                        .snapshots(),
                    builder: (BuildContext context, snapShot) {
                      switch (snapShot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: LoaderWidget());
                        default:
                          if (snapShot.hasError)
                            return Text('Error: ${snapShot.error}');
                          else if (snapShot.hasData) {
                            return ListView.builder(
                              // reverse: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapShot.data.docs.length,
                              itemBuilder: (BuildContext context, index) {
                                return activeUserWidget(
                                    createMessageFunction: () async {
                                      // TODO    createChatRoom
                                      UserService userService = UserService();
                                   
                                      String id =
                                          snapShot.data.docs[index]['uId'];
                                      log("Craete Chat Room");
                                      await userService.createChatRoom(id);
                                    },
                                    image: snapShot.data.docs[index]
                                            ['profilePic'] ??
                                        'https://www.oseyo.co.uk/wp-content/uploads/2020/05/empty-profile-picture-png-2-2.png',
                                    isActive: snapShot.data.docs[index]
                                            ['isOnline'] ??
                                        true,
                                    text: snapShot.data.docs[index]
                                            ['username'] ??'',
                                    context: context,
                                    callFunction: ()async {
                                       final UserModel _userModel = UserModel(
                                          uId: snapShot.data.docs[index]['uId'],
                                          username: snapShot.data.docs[index]['username'],
                                          profilePic: snapShot.data.docs[index]['profilePic'],
                                      
                                      );
                                      UserService userService = UserService();
                                      String _id = await CashLogin.getData(key: 'uId');
                                    final UserModel _userFrom = await userService.getUserProfile(_id);

                                    await CallUtils().dial(context: context,from: _userFrom,to: _userModel);

                                     log("User Modekkkkkkkkkkkkkkkkkl "+_id);
                                     Provider.of<RouterRight>( context, listen: false, ).changeRightScreen(VoiceCallPage( userModel: _userModel, userFrom:_userFrom));

                                    });
                              },
                            );
                          }
                          return Center(
                            child: Text('No Friends Yet'),
                          );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}

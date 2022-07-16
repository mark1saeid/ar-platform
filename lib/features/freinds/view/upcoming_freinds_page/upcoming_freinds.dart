import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/core/generalwidget/loader_widget.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';
import 'package:ratering_gen_zero/features/freinds/constant.dart';
import 'package:ratering_gen_zero/features/freinds/general_widgets/upcoming_friend_widget.dart';
import '../../services/upcoming_services.dart';

class UpcomingFriendsScreen extends StatefulWidget {
  static const String id = 'UpcomingFriendsScreen';

  @override
  State<UpcomingFriendsScreen> createState() => _UpcomingFriendsScreenState();
}

class _UpcomingFriendsScreenState extends State<UpcomingFriendsScreen> {
 
 

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(myId)
                .collection('pending')
                .snapshots(),
            builder: (context, snapShot) {
              print("id ${myId}");
              switch (snapShot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: LoaderWidget());
                default:
                  if (snapShot.hasError)
                    return Text('Error: ${snapShot.error}');
                  else if (snapShot.hasData) {
                  return   ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        return upcomingFriendWidget(
                            userName: snapShot.data.docs[index]['username'],
                            confirmFun: () {
                              acceptFriendRequestMethod(
                                  snapshot: snapShot.data.docs[index].reference,
                                  username: snapShot.data.docs[index]
                                      ['username']);
                            },
                            deleteFun: () {
                              deleteFriendRequestMethod(
                                snapshot: snapShot.data.docs[index].reference,
                              );
                            });
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                      itemCount: snapShot.data.docs.length,
                    );
                  }
              }
              return SizedBox(
                height: 20,
              );
            });
  }
}

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import 'package:ratering_gen_zero/features/freinds/constant.dart';

class AddFriendProvider extends ChangeNotifier {
  UserModel receiverModel;
  bool search = false;
  bool isPending;
  bool sendAddSuccess;

  searchSingleUserMethod({String userName}) {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['username'] == userName) {
          receiverModel = UserModel.fromJson(element.data());
          log(receiverModel.name);
          log(receiverModel.profilePic);
          search = true;
          notifyListeners();
          return;
        }
      });
    });
  }

  sendFollowRequestMethod() async {
   String username = await getMyUserName();
  await  FirebaseFirestore.instance
        .collection('users')
        .doc(receiverModel.uId)
        .collection('pending')
        .doc(myId)
        .set({
      'username':username ,
    }).then((value) {
      sendAddSuccess = true;
    });
    notifyListeners();
  }
}
Future<String> getMyUserName() async {
   String username ;
  await  FirebaseFirestore.instance
        .collection('users')
        .doc(myId)

        .get().then((value){
username = UserModel.fromJson(value.data()).username;
        });
        return username;
}
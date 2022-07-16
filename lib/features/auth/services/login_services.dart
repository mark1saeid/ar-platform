import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/shared_preferences.dart';
import '../../freinds/constant.dart';
import '../model/user_model.dart';

class LoginServices {

 Future<bool> loginSubmit({
    @required String email,
    @required String password,
  }) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {

    if(value.user != null){
      String id = value.user.uid;
      myId = id;
      CashLogin.saveData(
          key: 'uId', value: id);
      return true;
    }
    else{
      return false;
    }


    });
  }


}

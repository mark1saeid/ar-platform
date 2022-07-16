import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';
import 'package:ratering_gen_zero/features/freinds/constant.dart';
import '../../../core/shared_preferences.dart';
import '../model/user_model.dart';

class SignUpServices {
  // UserModel userModel;

 Future<void> signUpSubmit({
    @required String email,
    @required String password,
    @required String userName,
    //  @required BuildContext context,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      createUser(
        email: email,
        uId: value.user.uid,
        userName: userName,
      );
      CashLogin.saveData(
          key: 'uId', value: FirebaseAuth.instance.currentUser.uid);
    });
  }

  createUser({
    @required String email,
    String userName,
    String uId,
    String profilePic,
  }) async {
    UserModel model = UserModel(
      username: userName,
      email: email,
      phone: '',
      uId: uId,
      profilePic:
          'https://www.oseyo.co.uk/wp-content/uploads/2020/05/empty-profile-picture-png-2-2.png',
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson());
  }
}

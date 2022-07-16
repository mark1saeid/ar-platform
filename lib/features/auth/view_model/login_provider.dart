import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_preferences.dart';
import '../../freinds/constant.dart';
import '../model/user_model.dart';


class LoginProvider extends ChangeNotifier {
  IconData suffixIcon = Icons.remove_red_eye_outlined;
  bool isShownPassword = true;
  UserModel userModel;
  bool loginSucess = false;

  void changeFormFieldSuffix() {
    isShownPassword = !isShownPassword;
    suffixIcon = isShownPassword
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_rounded;
    notifyListeners();
  }

  loginSubmit({
    @required String email,
    @required String password,
    // BuildContext context,
  }) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      myId = value.user.uid;          //ahmed
      CashLogin.saveData(key: 'uId', value: myId);
      getMyData();
      pushToMain();
      notifyListeners();
    }).catchError((error) {
      notifyListeners();
    });
  }

  getMyData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc('$myId')
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());
      notifyListeners();
    }).catchError((e) {
    });
  }

  pushToMain() {
    loginSucess = true;
    notifyListeners();
  }
}

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import 'package:ratering_gen_zero/core/shared_preferences.dart';

import '../../freinds/constant.dart';

class SignUpProvider extends ChangeNotifier {
  IconData suffixIcon = Icons.remove_red_eye_outlined;
  bool isShownPassword = true;

  void changeFormFieldSuffix() {
    isShownPassword = !isShownPassword;
    suffixIcon = isShownPassword
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_rounded;
    notifyListeners();
  }

}

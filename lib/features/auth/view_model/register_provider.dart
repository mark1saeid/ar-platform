import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';
import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import 'package:ratering_gen_zero/core/shared_preferences.dart';
import 'package:ratering_gen_zero/features/freinds/constant.dart';

class RegisterProvider extends ChangeNotifier {
  IconData suffixIcon = Icons.remove_red_eye_outlined;
  bool isShownPassword = true;
  UserModel userModel;
  bool signUpScucess = false;
  bool isLoading = true;

  signUpSubmit({
    @required String email,
    @required String password,
    @required String userName,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUser(
        email: email,
        uId: value.user.uid,
        userName: userName,
      );
      CashLogin.saveData(key: 'uId', value: FirebaseAuth.instance.currentUser.uid);

      getMyData();
      pushToMain();
      log(userModel.profilePic.toString());
      notifyListeners();
    }).catchError((error) {
      log(error.toString());
      notifyListeners();
    });
  }

  void changeFormFieldSuffix() {
    isShownPassword = !isShownPassword;
    suffixIcon = isShownPassword
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_rounded;
    notifyListeners();
  }

  createUser({
    @required String email,
    // String phoneNumber,
    String userName,
    String uId,
    String profilePic,
    // String bio,
  }) {
    UserModel model = UserModel(
      username: userName,
      email: email,
      phone: '',
      uId: uId,
      profilePic:
          'https://www.oseyo.co.uk/wp-content/uploads/2020/05/empty-profile-picture-png-2-2.png',
    );
    notifyListeners();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      notifyListeners();
    }).catchError((error) {
      print(error.toString());
      notifyListeners();
    });
  }

  File profileImage;
  bool pickedPic = false;
  ImagePicker imagePicker = ImagePicker();

  Future<void> getProfilePic() async {
    final XFile pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      pickedPic = true;
      profileImage = File(pickedImage.path);
      notifyListeners();
    } else {
      pickedPic = false;
      notifyListeners();
    }
  }

  uploadProfilePic({
    @required String name,
    @required String bio,
    @required String phoneNumber,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage.path)}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          bio: bio,
          phoneNumber: phoneNumber,
          profilePic: value,
        );
      }).catchError((e) {
        notifyListeners();
      });
    }).catchError((onError) {
      notifyListeners();
    });
  }

  updateUser({
    @required String name,
    @required String bio,
    @required String phoneNumber,
    String profilePic,
  }) {
    UserModel model = UserModel(
      name: name ?? userModel.name,
      bio: bio ?? userModel.bio,
      phone: phoneNumber ?? userModel.phone,
      email: userModel.email,
      profilePic: profilePic ?? userModel.profilePic,
      uId: userModel.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toJson())
        .then((value) {
      notifyListeners();
    }).catchError((e) {
      notifyListeners();
    });
  }

  pushToMain() {
    signUpScucess = true;
    notifyListeners();
  }

  getMyData() async{
 
   await FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      log('errorrrr' + e);
      notifyListeners();
    });
  }
}

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';
import '../../freinds/constant.dart';
import '../model/user_model.dart';

class EditProfileProvider extends ChangeNotifier {
  UserModel userModel;

  getMyData() async{
    
   await FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());
     // myUsername = userModel.username;
      log(userModel.uId);
      log(userModel.email);
      log(userModel.profilePic);
      log(userModel.name);
      log(userModel.username);
    });
  }

  File profileImage;
  String myPicture = '';
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

  uploadToFireBase({
    @required String name,
    @required String bio,
    @required String phoneNumber,
    @required String picture,
  }) {
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user/${Uri.file(profileImage.path)}')
          .putFile(profileImage)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          myPicture = value;
          updateUser(
            email: userModel.email,
            uId: userModel.uId,
            profilePic: value ?? picture,
            name: name,
            bio: bio,
            phoneNumber: phoneNumber,
          );
        });
      });
    } else {
      updateUser(
        email: userModel.email,
        uId: userModel.uId,
        profilePic:
            'https://www.oseyo.co.uk/wp-content/uploads/2020/05/empty-profile-picture-png-2-2.png',
        name: name ?? userModel.name,
        bio: bio ?? userModel.bio,
        phoneNumber: phoneNumber ?? userModel.phone,
      );
    }
    notifyListeners();
  }

  updateUser({
    @required String name,
    @required String bio,
    @required String phoneNumber,
    @required String profilePic,
    @required String email,
    @required String uId,
  }) {
    UserModel model = UserModel(
      name: name ?? userModel.name,
      bio: bio ?? userModel.bio,
      phone: phoneNumber ?? userModel.phone,
      email: email ?? userModel.email,
      profilePic: profilePic ??
          'https://www.oseyo.co.uk/wp-content/uploads/2020/05/empty-profile-picture-png-2-2.png',
      uId: userModel.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toJson());
  }
}

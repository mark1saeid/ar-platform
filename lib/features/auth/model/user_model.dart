import 'dart:convert';

class UserModel {
  String name;
  String username;
  String email;
  String phone;
  String uId;
  String profilePic;
  String bio;
  bool isOnline;
  bool isVerified;
  
  
  UserModel({
     this.name,
     this.username,
     this.email,
     this.phone,
     this.uId,
     this.profilePic,
     this.bio,
     this.isOnline,
     this.isVerified,
  });

  


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'uId': uId,
      'profilePic': profilePic,
      'bio': bio,
      'isOnline': isOnline,
      'isVerified': isVerified,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      uId: map['uId'] ?? '',
      profilePic: map['profilePic'] ?? '',
      bio: map['bio'] ?? '',
      isOnline: map['isOnline'] ?? false,
      isVerified: map['isVerified'] ?? false,
    );
  }

  
}

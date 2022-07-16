import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import 'package:ratering_gen_zero/features/auth/services/local_service.dart';
import 'package:ratering_gen_zero/features/chat/model/chat_message.dart';
import 'package:ratering_gen_zero/features/freinds/constant.dart';
import '../../chat/model/chat_room.dart';

class UserService {
  //todo  Get user from firebase
  Future<List<dynamic>> getAllUsers() async {
    List<dynamic> users = [];
    await FirebaseFirestore.instance.collection('users').get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        users.add(doc.data());
      });
    });
    print(users.toString());
    return users;
  }

  Future<UserModel> getUserProfile(String id) async {
    UserModel userModel;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());
      print("  userModel  :: " + userModel.name.toString());
    });
    return userModel;
  }

 


  

  // Todo create chat room

  createChatRoom(
    String userId,
  ) async {
    bool isRoomExist = false;
  

    await FirebaseFirestore.instance.collection("chats").get().then((value) {
      value.docs.forEach((doc) {
        //user1 Ma
        if ((doc['members'].contains(myId) &&
                doc['members'].contains(userId)) ||
            (doc['members'].contains(userId) &&
                doc['members'].contains(myId))) {
          print('chat room already exists');
          isRoomExist = true;
        }
      });

      if (!isRoomExist) {
        FirebaseFirestore.instance.collection("chats").doc().set({
          "members": [myId, userId],
        });
      }
    });
    // chatroom does not exists
  }

  // todo get chat rooms

  Future<List<ChatRoom>> getChatRooms() async {
  
    List<ChatRoom> chatRooms = [];

    await FirebaseFirestore.instance
        .collection("chats")
        .where('members', arrayContains: myId)
        .get()
        .then((value) async {
      var elements = value.docs;
      for (var e in elements) {
        UserModel otherUser;
        String details = await getChatRoomDetails(e.id);
        otherUser = await getUserProfile(details);
        List<ChatMessage> chatMessages = await getChatMessages(e.id);
        if (chatMessages.isEmpty) {
          log("messages is empty");
          chatRooms.add(ChatRoom(
              otherUser: otherUser,
              chatMessages: [
                ChatMessage(
                  message: "Say Hi to ${otherUser.uId}",
                  senderID: otherUser.uId,
                )
              ],
              chatRoomID: e.id));
        } else {
          log("messages NOT empty");
          chatRooms.add(ChatRoom(
              otherUser: otherUser,
              chatMessages: chatMessages.toList(),
              chatRoomID: e.id));
        }
      }
    });
    log("chatRooms :: " + chatRooms.length.toString());
    return chatRooms.toList();
  }

  Future<String> getChatRoomDetails(String chatRoomId) async {
   
    String otherUserId;
    final snapshot = await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatRoomId)
        .get();

    snapshot.data()['members'].forEach((element) {
      if (element != myId) {
        otherUserId = element;
      }
    });

    return otherUserId;
  }

  Future<List<ChatMessage>> getChatMessages(String chatRoomId) async {
   
    List<ChatMessage> chatMessages = [];
    final snapshot = await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatRoomId)
        .collection('messages')
        .get();

    if (snapshot.docs.isEmpty) {
      return chatMessages;
    } else {
      if (snapshot.docs.length > 0) {
        var element = snapshot.docs;
        for (var e in element) {
          chatMessages.add(ChatMessage.fromJson(e.data()));
        }
      }
    }

    return chatMessages.toList();
  }

  // todo Send Message

  Future<void> sendMessage(String roomId, String message) async {
   
    final refMessages = FirebaseFirestore.instance
        .collection('chats')
        .doc(roomId)
        .collection('messages');

    final newMessage = ChatMessage(
      message: message,
      senderID: myId,
      
    );
    await refMessages.add(newMessage.toJson());
  }

  /* getUserChats() async {
    List<String> chatsId = [];

    await FirebaseFirestore.instance
        .collection('users')
        .doc("0vj8A8eTsLXknKkyov02AKV3MOB3")
        .collection('chats')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        print("ID" + doc.id.toString());
        chatsId.add(doc.data()['id']);
      });
    });
    //sa7
    List<List<ChatMessage>> chats = [];
    chatsId.forEach((e) {
      List<ChatMessage> messages = [];
      FirebaseFirestore.instance
          .collection('chats')
          .doc('FesbZ9xAY3XO9ltJyFXk')
          .collection('messages')
          .add(
              {'message': 'Hello', 'senderId': '0vj8A8eTsLXknKkyov02AKV3MOB3'});
    });
  }*/

  // Todo =========================================

  /* Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }*/

  /* Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots();
  }*/

  updateLastMessageSend(String chatRoomId, Map lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  /* Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }*/

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }
}

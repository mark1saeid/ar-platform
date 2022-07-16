import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ChatProvider extends ChangeNotifier {
//  List<ChatUsers> chatUsers;

  // search for chat  ahmed
  searchChat(String receiverName) {
    FirebaseFirestore.instance
        .collection('chat')
        .where("receiverName",isEqualTo: receiverName).snapshots();
  }


}

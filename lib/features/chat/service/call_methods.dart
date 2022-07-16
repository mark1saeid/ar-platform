import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import 'package:ratering_gen_zero/features/chat/model/call.dart';



class CallMethods {
  final CollectionReference callCollection =
      FirebaseFirestore.instance.collection("calls");

  Stream<DocumentSnapshot> callStream({String uid}) =>
      callCollection.doc(uid).snapshots();

  Future<bool> makeCall({Call call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toMap(call);

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);

      await callCollection.doc(call.callerId).set(hasDialledMap);
      await callCollection.doc(call.receiverId).set(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCall({UserModel from , UserModel to}) async {
    try {
      await callCollection.doc(from.uId).delete();
      await callCollection.doc(to.uId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
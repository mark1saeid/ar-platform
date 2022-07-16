import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';
import '../constant.dart';

acceptFriendRequestMethod({
  String username,
  DocumentReference<Object> snapshot,
}) async {
  UserModel model = await getDataUserNameMethod(userName: username);
  
  await FirebaseFirestore.instance
      .collection('users')
      .doc(myId)
      .collection('friends')
      .doc(model.uId)
      .set({
    'profilePic': model.profilePic,
    'uId': model.uId,
    'isOnline': model.isOnline,
    'username': model.username,
  }).then((value) {
    deleteFriendRequestMethod(
      snapshot: snapshot,
    );
  });
}

deleteFriendRequestMethod({
  DocumentReference<Object> snapshot,
}) async {
  await FirebaseFirestore.instance
      .runTransaction((Transaction myTransaction) async {
    myTransaction.delete(snapshot);
  });
}

Future<UserModel> getDataUserNameMethod({String userName}) async {
  var value = await FirebaseFirestore.instance.collection('users').get();
  var data = value.docs
      .where((element) => element.data()['username'] == userName)
      .first;
  return UserModel.fromJson(data.data());
}

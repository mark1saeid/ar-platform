import 'dart:math';

import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import 'package:ratering_gen_zero/features/chat/model/call.dart';
import 'package:ratering_gen_zero/features/chat/service/call_methods.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  dial({UserModel from, UserModel to, context}) async {
    Call call = Call(
      callerId: from.uId,
      callerUsername: from.username,
      callerPic: from.profilePic,
      receiverId: to.uId,
      receiverUsername: to.username,
      receiverPic: to.profilePic,
      channelId: Random().nextInt(1000).toString(),
    );

    // bool callMade =
    await callMethods.makeCall(call: call);

    // call.hasDialled = true;
  }

  // bool callMade =

  // call.hasDialled = true;

}

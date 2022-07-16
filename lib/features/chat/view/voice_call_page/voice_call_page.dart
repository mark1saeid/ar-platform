import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/core/router/route_right.dart';
import 'package:ratering_gen_zero/core/shared_preferences.dart';
import 'package:ratering_gen_zero/core/utils/call_utils.dart';
import 'package:ratering_gen_zero/features/acitve_user/view/active_userr_page/active_user_page.dart';
import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import "package:agora_rtc_engine/rtc_engine.dart";
import "package:permission_handler/permission_handler.dart";
import "package:agora_rtc_engine/rtc_local_view.dart" as RtcLocalView;
import "package:agora_rtc_engine/rtc_remote_view.dart" as RtcRemoteView;
import 'package:ratering_gen_zero/features/chat/model/call.dart';
import 'package:ratering_gen_zero/features/chat/service/call_methods.dart';
import 'package:ratering_gen_zero/features/chat/service/voice_call_service.dart';

class VoiceCallPage extends StatefulWidget {
  String id = "VoiceCallPage";
  final UserModel userModel;
  final UserModel userFrom;

  VoiceCallPage({Key key, this.userModel, this.userFrom}) : super(key: key);

  @override
  State<VoiceCallPage> createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  int _remoteUid = 0;

  RtcEngine _engine;

  @override
  void initState() {
    initAgora();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.leaveChannel();
    _engine.destroy();
  }

  Future<void> initAgora() async {
    log("Start");
    await [Permission.microphone, Permission.camera].request();
    _engine = await RtcEngine.create(AgoraManager.appId);
     log("create");
    _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          log("local user $uid joined successfully");
        },
        userJoined: (int uid, int elapsed) {
          log("remote user $uid joined successfully");
          setState(() => _remoteUid = uid);
        },
        userOffline: (int uid, UserOfflineReason reason) {
          log("remote user $uid left call");
          setState(() => _remoteUid = 0);
          Provider.of<RouterRight>(
            context,
            listen: false,
          ).changeRightScreen(ActiveUserScreen());
        },
      ),
    );
     log("list");
    await _engine.joinChannel(
        AgoraManager.token, AgoraManager.channelName, null, 0);
         log("end");
  }

  Widget _renderRemoteAudio() {
    if (_remoteUid != 0) {
      return Text(
        "Calling with $_remoteUid",
        style: TextStyle(color: Colors.white),
      );
    } else {
      return Text(
        "Calling …",
        style: TextStyle(color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      await CallMethods()
                          .endCall(from: widget.userModel, to: widget.userFrom);
                      Provider.of<RouterRight>(
                        context,
                        listen: false,
                      ).changeRightScreen(ActiveUserScreen());
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // Spacer(),
                  // Switch(value: true, onChanged: (val) {},)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 44,
                  child: CircleAvatar(
                    radius: 42,
                    backgroundImage: NetworkImage(widget.userModel.profilePic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    widget.userModel.username,
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 23,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                _remoteUid == 0
                    ? Text(
                        "Calling …",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    : Text(
                        "Calling with $_remoteUid",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
              ],
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[800].withOpacity(0.6),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
              height: screenHeight * .1,
              child: Row(
                children: [
                  myIcons(
                      icon: Icons.volume_down_outlined,
                      onTap: () {},
                      cancelCall: false),
                  myIcons(
                      icon: Icons.mic_none_outlined,
                      onTap: () {},
                      cancelCall: false),
                  myIcons(
                      icon: Icons.call_end_outlined,
                      onTap: () async {
                        await CallMethods().endCall(
                            from: widget.userModel, to: widget.userFrom);
                        Provider.of<RouterRight>(
                          context,
                          listen: false,
                        ).changeRightScreen(ActiveUserScreen());
                      },
                      cancelCall: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget myIcons({IconData icon, Function onTap, bool cancelCall}) {
  return Expanded(
    child: InkWell(
      child: CircleAvatar(
        backgroundColor:
            cancelCall ? Colors.red : Colors.grey[500].withOpacity(0.6),
        radius: 25,
        child: Icon(
          icon,
          size: 22,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    ),
  );
}

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ratering_gen_zero/core/generalwidget/loader_widget.dart';
import 'package:ratering_gen_zero/core/generalwidget/rounded_hotspot_widget.dart';
import 'package:ratering_gen_zero/core/shared_preferences.dart';
import 'package:ratering_gen_zero/features/chat/model/call.dart';
import 'package:ratering_gen_zero/features/home/view/notfications_menu.dart';

class IncomeCallWidget extends StatefulWidget {
  const IncomeCallWidget({Key key}) : super(key: key);

  @override
  State<IncomeCallWidget> createState() => _IncomeCallWidgetState();
}

class _IncomeCallWidgetState extends State<IncomeCallWidget> {
  String _id;
  AudioPlayer _player;
  Stream<QuerySnapshot> _callsStream;

  initId() async {
    _id = await CashLogin.getData(key: 'uId');
  }

  Future<void> notificationCallSound() async {
    await _player.play(AssetSource('voice/call.mp3'));
  }

  @override
  void initState() {
    initId();
    _callsStream = FirebaseFirestore.instance.collection('calls').snapshots();
    _player = AudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _callsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.3),
              child: LoaderWidget(),
            );
          default:
            if (snapshot.hasError)
              return Icon(
                Icons.error,
                color: Colors.white,
              );
            if (snapshot.hasData) {
              Call call;
              snapshot.data.docs.forEach((element) {
                if (element.id == _id) {
                  call = Call(
                    callerId: element['caller_id'],
                    callerUsername: element['caller_username'],
                    callerPic: element['caller_pic'],
                    receiverId: element['receiver_id'],
                    receiverUsername: element['receiver_username'],
                    receiverPic: element['receiver_pic'],
                    channelId: element['channel_id'],
                    hasDialled: element['has_dialled'],
                  );
                }
              });

              if (call == null) {
                return NotficationsMenu();
              }

              (!call.hasDialled) ? notificationCallSound() : null;

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: RoundedHotSpotWidget(
                  widget: ListTile(
                    leading: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(call.hasDialled
                                ? call.receiverPic
                                : call.callerPic)),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      call.hasDialled
                          ? "You Make A Call Please Wait"
                          : "You Have a Call Go And Answer It",
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade500),
                    ),
                    title: Text(
                      call.hasDialled
                          ? "You Call " + call.receiverUsername
                          : call.callerUsername + " Calling You",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
              );
            }
        }

        return NotficationsMenu();
      },
    );
  }
}

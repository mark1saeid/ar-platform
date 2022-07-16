import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:ratering_gen_zero/core/generalwidget/loader_widget.dart';
import 'package:ratering_gen_zero/features/auth/model/user_model.dart';
import 'package:ratering_gen_zero/features/auth/services/user_service.dart';
import 'package:ratering_gen_zero/features/chat/general_widget/chat_bubble.dart';
import 'package:ratering_gen_zero/features/chat/general_widget/chat_detail_appbar.dart';
import 'package:ratering_gen_zero/features/chat/model/chat_message.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../core/voice/voice_service.dart';
import '../../../keyboard/provider/keyboard_provider.dart';
import 'package:record/record.dart';

List<String> label_label = [
  'bed',
  'bird',
  'cat',
  'dog',
  'down',
  'eight',
  'five',
  'four',
  'go',
  'happy',
  'house',
  'left',
  'marvin',
  'nine',
  'no',
  'off',
  'on',
  'one',
  'right',
  'seven',
  'sheila',
  'silence',
  'six',
  'stop',
  'unknown',
  'up',
  'yes'
];

enum MessageType {
  Sender,
  Receiver,
}

class ChatDetailPage extends StatefulWidget {
  static const String id = "ChatDetailPage";
  UserModel userModel;
  String chatRoomId;

  ChatDetailPage({this.chatRoomId, this.userModel});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController _voiceController;

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  bool isPredicting = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _voiceController = TextEditingController();
    _initSpeech();
  }

  @override
  void dispose() {
    _voiceController.clear();
    _voiceController.dispose();
    super.dispose();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    log("be listen");
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      if (result.recognizedWords != "" &&
          label_label.contains(result.recognizedWords)) {
        print("open $_lastWords");
        _lastWords = result.recognizedWords;
        _voiceController.text = _lastWords;
        log(_lastWords);
        Provider.of<KeyboardProvider>(
          context,
          listen: false,
        ).addKey(_lastWords+" ");
        _lastWords = "";
      }
    });
  }
String path = "";
  final record = Record();
  startRecord() async {
    if (await record.hasPermission()) {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      await record.start(
        path: '$tempPath/sent.wav',
        samplingRate: 16000,
      );
      setState(() {
        path = '$tempPath/sent.wav';
        isPredicting = true;
      });
    }
  }

  stopRecord() async {
    await record.stop();
    String prediction = await Future.delayed(Duration(seconds: 1),()=>"on right off") ;//await voiceRecognition(File(path));
    setState(() {
      isPredicting = false;
      path = "";
      Provider.of<KeyboardProvider>(
        context,
        listen: false,
      ).addKey(prediction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ChatDetailAppBar(userModel: widget.userModel),
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Expanded(
                // height: MediaQuery.of(context).size.height * 0.1,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .doc(widget.chatRoomId)
                        .collection('messages')
                    
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: LoaderWidget());
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData &&
                              snapshot.data.docs.isNotEmpty) {
                            List<ChatMessage> chatMessages = [];
                            for (var e in snapshot.data.docs) {
                              chatMessages.add(ChatMessage.fromJson(e.data()));
                            }
                            log("chatMessages" +
                                chatMessages.length.toString());
                            return ListView.builder(
                              itemCount: chatMessages.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                top: 4,
                                left: 2,
                                right: 2,
                                bottom: 4,
                              ),
                              // physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ChatBubble(
                                  chatMessage: chatMessages[index],
                                );
                              },
                            );
                          } else {
                            return Center(
                                child: ChatBubble(
                              chatMessage: ChatMessage(
                                senderID: "myId",
                                message: "HI Send me a message",
                                //  timestamp: Timestamp.now(),
                              ),
                            ));
                          }
                      }
                    })),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(
                  // left: 16,
                  bottom: 10,
                  // right: 16,
                ),
                height: 50,
                width: double.infinity,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
        setState(() {
    _speechToText.isNotListening
                              ? _startListening()
                              : _stopListening();
                        });
                    /*     isPredicting ? stopRecord() : startRecord();*/
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          // color: Colors.blueGrey,
                          color:
                              Colors.black.withOpacity(0.3), //edited by ahmed
                        ),
                        child: Icon(
                          !_speechToText.isListening ? Icons.mic_none_outlined : Icons.mic,
                          color:  !_speechToText.isListening ? Colors.white : Colors.green,
                          size: 21,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(child: Consumer<KeyboardProvider>(
                        builder: (BuildContext context, value, Widget child) {
                      print("open" + value.text);
                      _voiceController.text = value.text;
                      return TextField(
                        onTap: () {
                          Provider.of<KeyboardProvider>(
                            context,
                            listen: false,
                          ).changeKeyboardState();
                        },
                        key: _formKey,
                        readOnly: true,
                        showCursor: true,
                        onChanged: (textValue) {
                          _voiceController.text = textValue;
                        },
                        controller: _voiceController,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            //  borderRadius: BorderRadius.circular(20),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            //  borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Type message...",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 12),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      );
                    })),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Provider.of<KeyboardProvider>(
                          context,
                          listen: false,
                        ).clear();
                        _lastWords = "";
                        await UserService().sendMessage(
                          widget.chatRoomId,
                          _voiceController.text,
                        );
                        _voiceController.clear();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Colors.black.withOpacity(0.3), // edited by ahmed
                          // color: Colors.black,
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

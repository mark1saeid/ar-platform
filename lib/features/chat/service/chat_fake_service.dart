import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class ChatFakeService {
  Map<String, dynamic> data;
  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');

    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }
  //assets/chat_data.json

  Future<Map<String, dynamic>> getData() async {
    data = await parseJsonFromAssets('assets/chat_data.json');

    return data;
  }

  Future<List<dynamic>> getChatFriends() async {
    await getData();
    List<dynamic> res = data['profile']['friends'];
    return res;
  }

  Future<List<dynamic>> getChatMessages() async {
    await getData();
    List<dynamic> res = data['friends'];
    return res;
  }

  Future<List<dynamic>> getOnlineFriend() async {
    await getData();
    List<dynamic> res = data['onlinefriends'];
    print("res: ${res.toString()}");
    return res;
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/news_model.dart';

Future<News> getNews() async {
  var url = Uri.parse('https://saurav.tech/NewsAPI/everything/cnn.json');
  http.Response response = await http.get(url);
  try {
    if (response.statusCode == 200) {
      return News.fromJson(jsonDecode(response.body));
    } else {
      return News();
    }
  } catch (e) {
    return News();
  }
}
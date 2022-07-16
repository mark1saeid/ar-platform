import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ratering_gen_zero/features/weather/model/weather_model.dart';


Future<Whether> getWhether() async {
  var url = Uri.parse('https://weatherdbi.herokuapp.com/data/weather/cairo');
  http.Response response = await http.get(url);
  try {
    if (response.statusCode == 200) {
      return Whether.fromJson(jsonDecode(response.body));
    } else {
      return Whether();
    }
  } catch (e) {
    return Whether();
  }
}
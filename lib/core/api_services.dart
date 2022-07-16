import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  String url =
      "https://activegym-1c716-default-rtdb.europe-west1.firebasedatabase.app";

  Future<void> storeData(String route, Map body) async {
    await http.post(Uri.parse("$url/$route/.json"), body: body);
  }

  Future<void> updateData(String route, Map body) async {
    await http.patch(Uri.parse("$url/$route/.json"), body: body);
  }

  Future<void> deleteData(String route, Map body) async {
    await http.delete(Uri.parse("$url/$route/.json"), body: body);
  }

  Future<dynamic> getData(String route) async {
    Response response = await http.get(Uri.parse("$url/$route/.json"));
    return response.body;
  }
}

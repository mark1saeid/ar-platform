import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:convert';

Future<Uint8List> _readFileByte(String filePath) async {
  Uri myUri = Uri.parse(filePath);
  File audioFile = new File.fromUri(myUri);
  Uint8List bytes;
  await audioFile.readAsBytes().then((value) {
    bytes = Uint8List.fromList(value);
    print('reading of bytes is completed');
  }).catchError((onError) {
    print('Exception Error while reading audio from path:' +
        onError.toString());
  });
  return bytes;
}

Future<String> voiceRecognition(File file) async {
  try {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    ByteData bytes =
    await rootBundle.load('assets/voice/sent2.wav'); //load sound from assets
    Uint8List soundbytes =
    bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    var postUri = Uri.parse("https://2b14-20-125-102-166.ngrok.io/");
   var request = http.MultipartRequest("POST", postUri);
    log("Path : "+'$tempPath/sent.wav');
  //  final record = http.MultipartFile.fromBytes('imageFile', File('$tempPath/record.wav').readAsBytesSync(), filename: "record.wav", contentType: MediaType("application", "json"));
    final record =  http.MultipartFile.fromBytes('imageFile',soundbytes, filename: "sent.wav", contentType: MediaType("application", "json"));

    request.files.add(record);
    var response = await request.send();
    var data = await http.Response.fromStream(response);
    log("status: ${response.statusCode.toString()}");
    log("result: ${data.body.toString()}");

    if(response.statusCode == 200){
      return json.decode(data.body)["result"];
  }else{
      return "something went wrong";
    }



  }catch(e){
    log(e.toString());
    return "error";
  }
}

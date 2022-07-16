import 'package:ratering_gen_zero/core/api_services.dart';

class ChatService {
  Future<String> getMessagesReciver() async {
    var message = await ApiService()
        .getData("/chatMessages/-Lsfsd234xda/-LrDEBo-MessageUID/message");
   
    return message.toString();
  }

  Future<String> getMessagesSender() async {
    var message = await ApiService()
        .getData("/chatMessages/-Lsfsd234xda/-LrDEBo1-MessageUID/message");
  
    return message.toString();
  }
}
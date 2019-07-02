import 'dart:convert';
import 'package:http/http.dart' as Http;

// Hear Package...
import 'package:hear/Services/Services.dart';
import 'package:hear/models.dart';

class ConversationServices extends Services {

  void conversations({Function onSuccess, Function onError}){
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.get("$HOST/conversations", headers: HEADERS).then((response) {
        int statusCode = response.statusCode;
        var responseBody = jsonDecode(response.body);
        if (statusCode == 200) {
          Iterable responseItems = responseBody; 
          List<Conversation> conversations = responseItems.map((item) => Conversation.fromJson(item)).toList();
          onSuccess(conversations);
          return;
        }
        onError(responseBody);
      });
    });
  }

  void create({Function onSuccess, Function onError}){
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.post("$HOST/conversations", headers: HEADERS).then((response) {
        int statusCode = response.statusCode;
        var responseBody = jsonDecode(response.body);
        if (statusCode == 200) {
          Conversation conversation = Conversation.fromJson(responseBody);
          onSuccess(conversation);
          return;
        }
        onError(responseBody);
      });
    });
  }
}
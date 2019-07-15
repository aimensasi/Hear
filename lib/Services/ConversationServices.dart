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

  void conversation({int id, Function onSuccess, Function onError}){
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.get("$HOST/conversations/$id", headers: HEADERS).then((response) {
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

  void rename({ int id, String name, Function onSuccess, onError }){
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";
      var body = jsonEncode({ "name": name });
      
      Http.patch("$HOST/conversations/$id", headers: HEADERS, body: body).then((response) {
        int statusCode = response.statusCode;
        var responseBody = jsonDecode(response.body);
        if (statusCode == 200) {
          onSuccess();
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
  
  void delete({int id, Function onSuccess, Function onError}){
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.delete("$HOST/conversations/$id", headers: HEADERS).then((response) {
        int statusCode = response.statusCode;
        var responseBody = jsonDecode(response.body);
        if (statusCode == 200) {
          onSuccess();
          return;
        }
        onError(responseBody);
      });
    });
  }

  send({ int id, String message, bool mine = true, Function onSuccess, onError }){
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";
      var body = jsonEncode({ "message": message, "mine": mine });
      
      Http.post("$HOST/conversations/$id/messages", headers: HEADERS, body: body).then((response) {
        int statusCode = response.statusCode;
        var responseBody = jsonDecode(response.body);
        if (statusCode == 200) {
          Message message = Message.fromJson(responseBody);
          onSuccess(message);
          return;
        }
        onError(responseBody);
      });
    });
  }

}
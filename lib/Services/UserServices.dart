import 'dart:convert';
import 'package:http/http.dart' as Http;

// Hear Package...
import 'package:hear/Services/Services.dart';
import 'package:hear/models.dart';

class UserServices extends Services {
  void currentUser({Function onSuccess, Function onError}) {
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.get("$HOST/current_user", headers: HEADERS).then((response) {
        int statusCode = response.statusCode;
        var responseBody = jsonDecode(response.body);
        if (statusCode == 200) {
          User user = User.fromJson(responseBody);
          onSuccess(user);
          return;
        }
        onError(responseBody);
      });
    });
  }

  void settings({Map<String, String> body, Function onSuccess, Function onError}){
    Auth.getInstance(onInstance: (Auth auth) {
      HEADERS["Authorization"] = "Bearer ${auth.accessToken}";

      Http.post("$HOST/settings", headers: HEADERS, body: jsonEncode(body)).then((response) {
        int statusCode = response.statusCode;
        var responseBody = jsonDecode(response.body);
        if (statusCode == 200) {
          onSuccess();
          return;
        }
        onError();
      });
    });
  }
}


import 'dart:convert';

import 'package:http/http.dart' as Http;

// Hear Package...
import 'package:hear/Services/Services.dart';

class AuthServices extends Services {
  register(
      {String email, String password, Function onSuccess, Function onError}) {
    var body = jsonEncode({"email": email, "password": password});

    Http.post("$HOST/register", headers: HEADERS, body: body).then((response) {
      int statusCode = response.statusCode;
      var responseBody = jsonDecode(response.body);
      if (statusCode == 200){
        token(grantType: "password", email: email, password: password, onSuccess: onSuccess, onError: onError);
        return;
      }
      onError( responseBody );
    });
  }

  token({String grantType, String email, String password, Function onSuccess, Function onError}){
    var body = jsonEncode({ 
      "grant_type": grantType, 
      "client_id": CLIENT_ID,
      "client_secret": CLIENT_SECRET,
      "username": email,
      "password": password,
      "scope": "*"
    });

    Http.post("$HOST/token", headers: HEADERS, body: body).then((response) {
      int statusCode = response.statusCode;
      var responseBody = jsonDecode(response.body);
      if (statusCode == 200){
        print("Response Body :: $responseBody");
        
        onSuccess( );
        return;
      }
      onError( responseBody );
    });

  }
}

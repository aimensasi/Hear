import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'Auth.g.dart';

@JsonSerializable()
class Auth {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'expires_in')
  int expiresIn;

  Auth({this.accessToken, this.refreshToken, this.expiresIn});

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  Map<String, dynamic> toJson() => _$AuthToJson(this);


  Future save() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('access_token', accessToken);
    prefs.setInt('expires_in', expiresIn);
    prefs.setString('refresh_token', refreshToken);
  }

  void getToken({String type = "access_token", Function onValue}) {
    SharedPreferences.getInstance().then((instance) {
      onValue(instance.getString(type));
    });
  }

  static void getInstance({Function onInstance}){
    SharedPreferences.getInstance().then((instance) {
      String accessToken = instance.getString("access_token");
      String refreshToken = instance.getString("refresh_token");
      int expiresIn = instance.getInt("expires_in");
      Auth auth = Auth(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn);
      onInstance(auth);
    });
  }

  static void erase({Function done}){
    SharedPreferences.getInstance().then((instance) {
      instance.remove("access_token");
      instance.remove("refresh_token");
      instance.remove("expires_in");
      done();
    });
  }
}
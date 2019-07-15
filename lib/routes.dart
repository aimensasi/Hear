import 'package:flutter/material.dart';
import 'package:hear/screens.dart';


class Routes {
  static routes(){
    return {
      '/': (BuildContext context) => SplashScreen(),
      '/login': (BuildContext context) => LoginScreen(),
      '/register': (BuildContext context) => RegisterScreen(),
      '/home': (BuildContext context) => HomeScreen(),
      '/setting': (BuildContext context) => AccountSettingScreen(),
      '/conversation': (BuildContext context) => ConversationScreen(),
      '/conversation/setting': (BuildContext context) => ConversationSettingScreen(),
    };
  }
}
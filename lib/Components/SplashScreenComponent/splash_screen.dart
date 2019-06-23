import 'package:flutter/material.dart';

// Hear Package...
import 'package:hear/utils.dart';
import 'package:hear/models.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  _setup(BuildContext context){
    Auth.getInstance(onInstance: (Auth auth){
      if (auth.accessToken == null){
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }else{
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // Initialize the app
    _setup(context);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: Decorations.background(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: CircularProgressIndicator(),
                    ),
                    Container(
                      margin: EdgeInsets.all(30),
                      child: Text("Loading..."),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

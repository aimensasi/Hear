import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> alert(BuildContext context, {title, body}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: TextStyle(fontSize: 14)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Color(0xFF20272D),
        content: SingleChildScrollView(
          padding: EdgeInsets.only(top: 10),
          child: ListBody(
            children: <Widget>[
              Text(
                body,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> processingDialog(BuildContext context, {String title = "Hold on"}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text("", style: TextStyle(fontSize: 14)),
          shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)
          ),
          backgroundColor: Colors.transparent,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: SpinKitDoubleBounce(
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
        );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:hear/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  // Gloable Unique Key to make the form unique
  final _formKey = GlobalKey<FormState>();

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "EmailAddress",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
              keyboardType: TextInputType.emailAddress,
            ),
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          ),
          Padding(
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Password",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  )),
              obscureText: true,
              keyboardType: TextInputType.text,
            ),
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 30),
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              padding: EdgeInsets.only(left: 90, right: 90, top: 10, bottom: 10),
              textColor: Color(0xFF20272D),
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                }

                Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                
              },
              child: Text("Login", style: TextStyle(fontSize: 18)),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 30),
            child: OutlineButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              borderSide: BorderSide(color: Colors.white),
              padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
              onPressed: () {
                Navigator.of(context).pushNamed('/register');
              },
              child: Text("Create Account", style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          decoration: Decorations.background(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 120),
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _buildForm(context),
                  )
                ],
              )
            ],
          )),
    );
  }
}

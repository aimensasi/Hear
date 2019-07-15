import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

// Hear Package...
import 'package:hear/utils.dart';
import 'package:hear/services.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  void onSubmit(BuildContext context) {
    processingDialog(context);
    AuthServices().register(
        email: _formData["email"],
        password: _formData["password"],
        onSuccess: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
        },
        onError: (response) {
          Navigator.of(context).pop();
          alert(context,
              title: "Email or password are incorrect",
              body: "Double check your credentials, something is wrong.");
        });
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            child: TextFormField(
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(_focusNode);
              },
              decoration: InputDecoration(
                  labelText: "Email Address",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
              keyboardType: TextInputType.emailAddress,
              validator: (String value) {
                if (value.isEmpty || !isEmail(value)) {
                  return "Invalid Email";
                }
                return null;
              },
              onSaved: (String value) {
                _formData['email'] = value;
              },
            ),
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          ),
          Padding(
            child: TextFormField(
              focusNode: _focusNode,
              textInputAction: TextInputAction.done,
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
              validator: (String value) {
                if (value.isEmpty || !isLength(value, 6)) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
              onSaved: (String value) {
                _formData['password'] = value;
              },
            ),
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 30),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              padding:
                  EdgeInsets.only(left: 90, right: 90, top: 10, bottom: 10),
              textColor: Color(0xFF20272D),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  onSubmit(context);
                }
              },
              child: Text("Register", style: TextStyle(fontSize: 18)),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 30),
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              borderSide: BorderSide(color: Colors.white),
              padding:
                  EdgeInsets.only(left: 100, right: 100, top: 10, bottom: 10),
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: Text("Login", style: TextStyle(fontSize: 18)),
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
          child: SingleChildScrollView(
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
            ),
          )),
    );
  }
}

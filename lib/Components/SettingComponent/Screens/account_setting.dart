import 'package:flutter/material.dart';

// Hear Package...
import 'package:hear/utils.dart';
import 'package:hear/models.dart';
import 'package:hear/services.dart';

class AccountSettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  // Gloable Unique Key to make the form unique
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, String> _formData = {};
  // final List<String> _languages = <String>["English", "French", "Spanish"];
  User _currentUser = User();

  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _currentPasswordController = TextEditingController();

  @override
  void initState() {
    UserServices().currentUser(onSuccess: (User user) {
      setState(() {
        _currentUser = user;
      });
    }, onError: (response) {
      showSnackBar();
    });
    super.initState();
  }

  void onSubmit(BuildContext context) {
    UserServices().settings(
        body: _formData,
        onSuccess: () {
          showSnackBar(content: "Changes Saved");
        },
        onError: () {
          showSnackBar();
        });
  }

  void onLogout() {
    Auth.erase(done: () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    });
  }

  void showSnackBar({content = "Something Went wrong, try again later"}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        content,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Color(0xFF8A9DAB),
    ));
  }

  Widget _buildForm(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        // FormField(builder: (FormFieldState state) {
        //   return InputDecorator(
        //     decoration: InputDecoration(
        //       labelText: 'Language',
        //       labelStyle: TextStyle(fontSize: 20, color: Colors.white),
        //     ),
        //     isEmpty: _formData['language'] == "",
        //     child: Padding(
        //       padding: EdgeInsets.only(top: 15),
        //       child: new DropdownButtonHideUnderline(
        //         child: new DropdownButton(
        //           isDense: true,
        //           value: _formData['language'],
        //           onChanged: (String value) {
        //             setState(() {
        //               _formData['language'] = value;
        //             });
        //           },
        //           items: _languages.map((String language) {
        //             return DropdownMenuItem(
        //               value: language,
        //               child: new Text(language),
        //             );
        //           }).toList(),
        //         ),
        //       ),
        //     ),
        //   );
        // }),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Text("Email Address: ${_currentUser.email}", style: TextStyle(fontSize: 14),),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Text("Change Password", style: TextStyle(fontSize: 18),),
        ),
        Padding(
          child: TextFormField(
            controller: _currentPasswordController,
            decoration: InputDecoration(
              labelText: "Current Password",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelStyle: TextStyle(color: Colors.white),
            ),
            obscureText: true,
            keyboardType: TextInputType.text,
            onSaved: (String value) {
              _formData['current_password'] = value;
            },
          ),
          padding: EdgeInsets.only(bottom: 20),
        ),
        Padding(
          child: TextFormField(
            controller: _newPasswordController,
            decoration: InputDecoration(
              labelText: "New Password",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelStyle: TextStyle(color: Colors.white),
            ),
            obscureText: true,
            keyboardType: TextInputType.text,
            validator: (String value) {
              if (_currentPasswordController.text.isNotEmpty) {
                if (value.isEmpty) {
                  return "New password must be at least 6 characters";
                }
              }
              return null;
            },
            onSaved: (String value) {
              _formData['password'] = value;
            },
          ),
          padding: EdgeInsets.only(bottom: 20),
        ),
        Padding(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Confirm Password",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelStyle: TextStyle(color: Colors.white),
            ),
            obscureText: true,
            keyboardType: TextInputType.text,
            validator: (String value) {
              if (_currentPasswordController.text.isNotEmpty) {
                if (value.isEmpty) {
                  return "Confirm password must be at least 6 characters";
                } else if (value != _newPasswordController.text) {
                  return "Password and confirm password must match";
                }
              }
              return null;
            },
            onSaved: (String value) {
              _formData['password_confirmation'] = value;
            },
          ),
          padding: EdgeInsets.only(bottom: 20),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 30),
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            padding: EdgeInsets.only(left: 90, right: 90, top: 10, bottom: 10),
            textColor: Color(0xFF20272D),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                onSubmit(context);
              }
            },
            child: Text("Save Changes", style: TextStyle(fontSize: 18)),
          ),
        )
      ],
    );
  }

  Widget _buildSettingForm(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30),
          child: Text(
            "Account Settings",
            style: TextStyle(fontSize: 20, fontFamily: 'Lato Medium'),
          ),
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: _buildForm(context),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF394247),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Color(0xFF8A9DAB),
            title: Container(
              padding: EdgeInsets.only(top: 20),
              child: Image.asset('assets/images/logo_small.png'),
            ),
            centerTitle: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.power_settings_new),
                tooltip: "Logout",
                onPressed: () {
                  onLogout();
                },
              )
            ],
          )),
      body: Container(
        alignment: Alignment.center,
        decoration: Decorations.background(),
        child: _buildSettingForm(context),
      ),
    );
  }
}

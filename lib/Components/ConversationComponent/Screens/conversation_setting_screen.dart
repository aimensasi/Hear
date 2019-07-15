import 'package:flutter/material.dart';

// Hear Package...
import 'package:hear/utils.dart';
import 'package:hear/models.dart';
import 'package:hear/services.dart';

class ConversationSettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConversationSettingScreenState();
}

class _ConversationSettingScreenState extends State<ConversationSettingScreen> {
  // Gloable Unique Key to make the form unique
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _titleController = TextEditingController();

  int _id;
  Conversation _conversation = Conversation();

  @override
  void initState() {
    super.initState();
  }

  void setDefaults() {
    if (_conversation.name != null) {
      return;
    }
    _id = ModalRoute.of(context).settings.arguments;

    ConversationServices().conversation(
        id: _id,
        onSuccess: (Conversation conversation) {
          setState(() {
            _conversation = conversation;
            print("Got Conversation");
            _titleController.text = _conversation.name;
          });
        },
        onError: (error) {
          showSnackBar();
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

  void onSaveChanges(BuildContext context){
    ConversationServices().rename(id: _id, name: _titleController.text, onSuccess: (){
      showSnackBar(content: "Changes Saved");
    }, onError: (){
      showSnackBar();
    });
  }

  void onDeleteConversation(BuildContext context){
    ConversationServices().delete(id: _id, onSuccess: (){
      showSnackBar(content: "Changes Saved");
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    }, onError: (){
      showSnackBar();
    });
  }

  Widget _buildSettingForm(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30),
          child: Text(
            "Conversation Settings",
            style: TextStyle(fontSize: 20, fontFamily: 'Lato Medium'),
          ),
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Conversation Title",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if(value.isEmpty){
                    return "You Must Prodive a Title";
                  }
                  return null;
                },
                onSaved: (String value) {},
              ),
            ),
          ),
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
                onSaveChanges(context);
              }
            },
            child: Text("Save Changes", style: TextStyle(fontSize: 18)),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 40, top: 10),
          child: RaisedButton(
            padding: EdgeInsets.all(0),
            textColor: Color(0xFF20272D),
            onPressed: () {
              onDeleteConversation(context);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: Container(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 65, right: 65),
              decoration: Decorations.recorderContainer(),
              child: Text("Delete Conversation",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    setDefaults();
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
          )),
      body: Container(
        alignment: Alignment.center,
        decoration: Decorations.background(),
        child: _buildSettingForm(context),
      ),
    );
  }
}

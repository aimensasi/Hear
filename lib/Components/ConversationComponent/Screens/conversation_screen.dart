import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hear/utils.dart';
import 'package:hear/models.dart';
import 'package:hear/services.dart';

class ConversationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _id;
  Conversation _conversation = Conversation();
  List<Message> _messages = [];
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
            _messages = conversation.messages;
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

  Widget _buildMessagesListItem(BuildContext context, int index) {
    Message message = _messages[index];
    print("Message ID :: ${message.id}, Type :: ${message.mine}");
    Widget widget;

    if (message.mine) {
      widget = Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 15, left: 35, right: 10),
        decoration: Decorations.rightMessageContainer(
            start: 0xFF2B3237, end: 0xFF2B3237),
        child: Text(
          message.message,
          style: TextStyle(fontSize: 14, height: 1.25),
        ),
      );
    } else {
      widget = Container(
        child: widget = Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: 20, left: 10, right: 35),
          decoration: Decorations.leftMessageContainer(
              start: 0xFF889BAB, end: 0xFF889BAB),
          child: Text(
            message.message,
            style: TextStyle(fontSize: 14, height: 1.25),
          ),
        ),
      );
    }

    return widget;
  }

  Widget _buildMessageListComponent(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemBuilder: _buildMessagesListItem, itemCount: _messages.length),
    );
  }

  Widget _buildRecorderComponent(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20, bottom: 20, left: 60, right: 60),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: Decorations.recorderContainer(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SpinKitWave(
            color: Colors.white,
            size: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(''),
          ),
          InkWell(
            child: Icon(Icons.stop, color: Colors.white,),
            onTap: () {
              print("Record");
            },
          )
        ],
      ),
    );
  }

  Widget _buildSendComponent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 25, left: 8, right: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Color(0xFF889BAB),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Say Something...',
                          hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: Color(0xFF889BAB),
              child: Icon(Icons.send, color: Colors.white, size: 20,),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildComponents(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30),
          child: Text(
            "${_conversation.name}",
            style: TextStyle(fontSize: 20, fontFamily: 'Lato Medium'),
          ),
        ),
        _buildMessageListComponent(context),
        _buildRecorderComponent(context),
        _buildSendComponent(context),
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
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                tooltip: "Settings",
                onPressed: () {
                  Navigator.of(context).pushNamed('/conversation/setting');
                },
              )
            ],
          )),
      body: Container(
        alignment: Alignment.center,
        decoration: Decorations.background(),
        child: buildComponents(context),
      ),
    );
  }
}

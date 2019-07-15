import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hear/utils.dart';
import 'package:hear/models.dart';
import 'package:hear/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ConversationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final ScrollController _listViewController = ScrollController();
  final TextEditingController _messageTextFieldController =
      TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PermissionStatus _permissionStatus = PermissionStatus.unknown;
  SpeechRecognition _speechRecognition;
  FlutterTts _flutterTts;

  bool _isAvailable = false;
  bool _isListening = false;
  bool _isSpeaking = false;

  // conversation id
  int _id;
  Conversation _conversation = Conversation();
  List<Message> _messages = [];
  Message _currentMessage;

  @override
  void initState() {
    super.initState();
    _currentMessage = Message(message: "", mine: false);
    requestPermission();
  }

  void requestPermission() {
    PermissionHandler().requestPermissions([PermissionGroup.microphone]).then(
        (Map<PermissionGroup, PermissionStatus> result) {
      var status = result.values.first;
      setState(() {
        _permissionStatus = status;
      });

      if (status == PermissionStatus.granted) {
        initSpeechRecognition();
      } else {
        showSnackBar(
            content:
                "Please Enable Microphone Permission To Be Able Use This Feature");
      }
    });
  }

  void initSpeechRecognition() {
    _speechRecognition = SpeechRecognition();
    _flutterTts = FlutterTts();

    _speechRecognition.setAvailabilityHandler((bool result) {
      if(result == false){
        showSnackBar(content: "Speech Recognition is not available on this phone");
      }
      setState(() {
        _isAvailable = result;
        if(_isListening){
          _isListening = false;
        }
      });
    });

    _speechRecognition.setRecognitionStartedHandler(() {
      setState(() {
        _isListening = true;
      });
    });

    _speechRecognition.setRecognitionResultHandler((String speech) {
      setState(() {
        _currentMessage.message = speech;
      });
    });

    _speechRecognition.setRecognitionCompleteHandler(() {
      onSend(context, message: _currentMessage.message, mine: false);
      setState(() {
        _isListening = false;
        _currentMessage.message = "";
      });
    });

    _speechRecognition.activate().then((result) {
      setState(() {
        _isAvailable = result;
      });
    });
  }

  void onSend(BuildContext context, {String message, bool mine = true}) {
    if (message.isEmpty) {
      showSnackBar(content: "Please provide a message to translate");
      return;
    }

    ConversationServices().send(
        id: _conversation.id,
        message: message,
        mine: mine,
        onSuccess: (Message message) {
          setState(() {
            _messages.add(message);
            _messageTextFieldController.clear();
          });
        },
        onError: (error) {
          print("Server Error :: $error");
          showSnackBar();
        });
  }

  void onStartRecording(BuildContext context) async {
    if (!_isAvailable) {
      showSnackBar(content: "Something Went Wrong, please try again later");
    }
    if (!_isListening) {
      _speechRecognition
          .listen(locale: "en_US")
          .then((result) => print('$result'));
    }
  }

  void onStopRecording(BuildContext context) async {
    if (_isListening) {
      _speechRecognition.cancel().then((result) {
        if (Platform.isIOS) {
          onSend(context, message: _currentMessage.message, mine: false);
          setState(() {
            _currentMessage.message = "";
            _isListening = result;
          });
        }
      });
    }
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

  Widget _leftSideComponent(BuildContext context, Message message) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20, left: 10, right: 35),
      decoration:
          Decorations.leftMessageContainer(start: 0xFF889BAB, end: 0xFF889BAB),
      child: Text(
        message.message,
        style: TextStyle(fontSize: 14, height: 1.25),
      ),
    );
  }

  Widget _rightSideComponent(BuildContext context, Message message) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 15, left: 35, right: 10),
      decoration:
          Decorations.rightMessageContainer(start: 0xFF2B3237, end: 0xFF2B3237),
      child: Text(
        message.message,
        style: TextStyle(fontSize: 14, height: 1.25),
      ),
    );
  }

  Widget _buildMessagesListItem(BuildContext context, int index) {
    Message message = _messages[index];
    Widget widget;
    print("Min Message ${message.mine}");
    if (message.mine) {
      widget = _rightSideComponent(context, message);
    } else {
      widget = _leftSideComponent(context, message);
    }

    return widget;
  }

  Widget _buildMessageListComponent(BuildContext context) {
    if (_isListening) {
      return Expanded(
        child: SingleChildScrollView(
          child: _leftSideComponent(context, _currentMessage),
        ),
      );
    }

    Timer(Duration(milliseconds: 500), () {
      if (_messages.length > 0) {
        _listViewController
            .jumpTo(_listViewController.position.maxScrollExtent);
      }
    });
    return Expanded(
      child: ListView.builder(
          controller: _listViewController,
          itemBuilder: _buildMessagesListItem,
          itemCount: _messages.length),
    );
  }

  Widget _buildRecorderComponent(BuildContext context) {
    List<Widget> widget;
    if (_isListening) {
      widget = [
        SpinKitWave(
          color: Colors.white,
          size: 20.0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(''),
        ),
        InkWell(
          child: Icon(
            Icons.stop,
            color: Colors.white,
          ),
          onTap: () {
            setState(() {
              onStopRecording(context);
            });
          },
        )
      ];
    } else {
      widget = [
        Text("Microphone is off"),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(''),
        ),
        InkWell(
          child: Icon(
            Icons.mic,
            color: Colors.white,
          ),
          onTap: () {
            onStartRecording(context);
          },
        )
      ];
    }

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20, bottom: 20, left: 60, right: 60),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: Decorations.recorderContainer(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget,
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
                        controller: _messageTextFieldController,
                        decoration: InputDecoration(
                          hintText: 'Say Something...',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 14),
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
            onTap: () {
              if(_isListening){
                onStopRecording(context);
              }
              onSend(context, message: _messageTextFieldController.text);
              _flutterTts.speak(_messageTextFieldController.text).then((result){
                if(result == 1){
                  setState(() {
                    _isSpeaking = true;
                  });
                }
              });
            },
            child: CircleAvatar(
              backgroundColor: Color(0xFF889BAB),
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildComponents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
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
                  Navigator.of(context).pushNamed('/conversation/setting', arguments: _conversation.id);
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
}

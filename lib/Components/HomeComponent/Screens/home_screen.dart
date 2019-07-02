import 'package:flutter/material.dart';
import 'package:hear/utils.dart';
import 'package:hear/models.dart';
import 'package:hear/services.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Conversation> _conversations = [];

  @override
  void initState() {
    setDefaults();
    super.initState();
  }

  void setDefaults(){
    ConversationServices().conversations(onSuccess: (List<Conversation> conversations) {
      setState(() {
        _conversations = conversations;
      });
    }, onError: (response) {
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

  Widget _emptyList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "No Conversations, yet",
          style: TextStyle(fontSize: 18),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Text("No Conversations saved yet, Start a new conversation",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100)),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 30),
          child: RaisedButton(
            color: Color(0xFF8A9DAB),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            padding: EdgeInsets.only(left: 90, right: 90, top: 10, bottom: 10),
            textColor: Color(0xFFFFFFFF),
            onPressed: () {},
            child: Text("Start a Conversation", style: TextStyle(fontSize: 14)),
          ),
        )
      ],
    );
  }

  Widget _buildConversationListItem(BuildContext context, int index) {
    Conversation conversation = _conversations[index];
    return GestureDetector(
        onTap: () {
          // handle list item tap
        },
        child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
            decoration: Decorations.roundedContainer(
                start: 0xFF2B3237, end: 0xFF2B3237),
            child: Text(conversation.name)));
  }

  Widget _buildConversationList(BuildContext context) {
    Widget widget = _emptyList(context);

    if (_conversations.length > 0) {
      widget = Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Text(
              "Conversations",
              style: TextStyle(fontSize: 20, fontFamily: 'Lato Medium'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: _buildConversationListItem,
              itemCount: _conversations.length,
            ),
          ),
        ],
      );
    }

    return widget;
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
                icon: Icon(Icons.settings),
                tooltip: "Settings",
                onPressed: () {
                  Navigator.of(context).pushNamed('/setting');
                },
              )
            ],
          )),
      body: Container(
        alignment: Alignment.center,
        decoration: Decorations.background(),
        child: _buildConversationList(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.hearing,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF8A9DAB),
      ),
    );
  }
}

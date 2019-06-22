import 'package:flutter/material.dart';
import 'package:hear/utils.dart';
import 'package:hear/models.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Conversation> _conversations = [];

  @override
  void initState() {
    _conversations.addAll([
      Conversation(id: 1, displayName: "conversation 1"),
      Conversation(id: 2, displayName: "conversation 2"),
      Conversation(id: 3, displayName: "conversation 3"),
      Conversation(id: 4, displayName: "conversation 4"),
      Conversation(id: 5, displayName: "conversation 5"),
      Conversation(id: 6, displayName: "conversation 6"),
      Conversation(id: 7, displayName: "conversation 7"),
      Conversation(id: 8, displayName: "conversation 8"),
      Conversation(id: 9, displayName: "conversation 9"),
      Conversation(id: 10, displayName: "conversation 10"),
    ]);
    super.initState();
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
            child: Text(conversation.displayName)));
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
              style: TextStyle(fontSize: 25, fontFamily: 'Lato Medium'),
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
                  // Implement on pressed
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

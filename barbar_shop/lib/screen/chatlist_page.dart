import 'package:barbar_shop/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    final db = Firestore.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 20,top: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Inbox",
                            style: TextStyle(
                                fontSize: 20
                            ),
                          ),
                          Container(

                              child: IconButton(
                                onPressed: (){

                                },
                                icon: Icon(Icons.search),
                              )
                          )
                        ],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20,top: 5),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "You Have ",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        Text(
                          "2 ",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        Text(
                          "Unread Message",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),

//
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder<List<Chat>>(
                  stream: db
                      .collection('groups')
                      .where('user', arrayContains: "5")
                      .orderBy('name')
                      .snapshots()
                      .map(firestoreToChatList),
                  builder: (context, AsyncSnapshot<List<Chat>> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('error: ${snapshot.error.toString()}'));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<Chat> chatList = snapshot.data;
                    return ListView.builder(
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            chatList[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(chatList[index].id),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/chat',
                              arguments: chatList[index],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/new').then((groupName) {
            String name = groupName;
            if (name != null && name.isNotEmpty) {
              db.collection('groups').document().setData({
                'name': groupName,
              });
            }
          });
        },
      ),
    );
  }
}
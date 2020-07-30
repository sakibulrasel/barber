import 'package:barbar_shop/controller/inbox_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("message")
                    .where("touser",isEqualTo: "f6iBtySGmLg71lkgoMkehR1koXy1")
                    .orderBy("createdAt",descending: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot){
                  if(querySnapshot.hasError){
                    return Center(
                      child: Text("Error"),
                    );
                  }
                  if(querySnapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }else{
                    final list = querySnapshot.data.documents;
                    return ListView.builder(
                        itemBuilder: (context, index){
                          return ListTile(
                            trailing: Text("3 min ago"),
                            title: Text(list[index]["fromUsername"]),
                            subtitle: Text(list[index]["message"]),
                          );
                        },
                      itemCount: list.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),

    );
  }
}

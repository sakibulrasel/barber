import 'package:barbar_shop/model/chat_model.dart';
import 'package:barbar_shop/model/message_model.dart';
import 'package:barbar_shop/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class MessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Chat chat = Provider.of<Chat>(context);
    return StreamBuilder<List<Message>>(
      stream: Firestore.instance
          .collection('groups/${chat.id}/messages')
          .orderBy('time', descending: true)
          .snapshots()
          .map(firestoreToMessageList),
      builder: (context, AsyncSnapshot<List<Message>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('ERROR: ${snapshot.error.toString()}'),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Message> docs = snapshot.data;
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 4),
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) => ChatMessage(docs[index]),
        );
      },
    );
  }
}
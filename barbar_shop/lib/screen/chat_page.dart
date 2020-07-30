import 'package:barbar_shop/model/chat_model.dart';
import 'package:barbar_shop/widgets/chat_background.dart';
import 'package:barbar_shop/widgets/message_edit_bar.dart';
import 'package:barbar_shop/widgets/message_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  ChatPage();

  @override
  Widget build(BuildContext context) {
    Chat chat = ModalRoute.of(context).settings.arguments;
    return Provider<Chat>.value(
      value: chat,
      child: Scaffold(
        appBar: AppBar(title: Text(chat.name)),
        body: Stack(
          children: <Widget>[
            ChatBackground(),
            Column(
              children: <Widget>[
                Expanded(child: MessageList()),
                MessageEditBar()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
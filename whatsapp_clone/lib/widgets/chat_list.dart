import 'package:flutter/material.dart';
import 'package:whatsapp_clone/info.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (messages[index]['isMe'] == true) {
          //MyMessage -> Card
        } else {
          //SenderMessage -> card
        }
      },
    );
  }
}

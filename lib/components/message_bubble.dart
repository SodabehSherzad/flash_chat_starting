import 'package:flutter/material.dart';
import 'package:flash_chat_starting/constants.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.sender,
  });

  final String message, sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(BubbleRadius),
          topLeft: Radius.circular(BubbleRadius),
          bottomLeft: Radius.circular(BubbleRadius),
          bottomRight: Radius.circular(BubbleRadius),
        ),
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              Text(sender!, style: TextStyle(fontSize: 12, color: kChatEmailColor),),
              SizedBox(height: 8,),
              Text(message!, style: TextStyle(fontSize: 16),),
            ],
          ),
        )),
    );
  }
}

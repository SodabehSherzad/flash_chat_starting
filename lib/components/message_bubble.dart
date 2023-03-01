import 'package:flutter/material.dart';
import 'package:flash_chat_starting/constants.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.sender,
    required this.isMe
  });

  final String message, sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Material(
          borderRadius: BorderRadius.only(
            topLeft: isMe ? Radius.circular(BubbleRadius) : Radius.circular(0),
            topRight: isMe ? Radius.circular(0) : Radius.circular(BubbleRadius),
            bottomLeft: Radius.circular(BubbleRadius),
            bottomRight: Radius.circular(BubbleRadius),
          ),
          color: isMe ? kSendButtonColor : kSenderBoxColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end: CrossAxisAlignment.start,
              children: [
                Text(sender, style: TextStyle(fontSize: 12, color: kChatEmailColor),),
                SizedBox(height: 8,),
                Text(message, style: TextStyle(fontSize: 16),),
              ],
            ),
          )),
      ),
    );
  }
}

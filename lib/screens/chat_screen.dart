import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_starting/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_starting/constants.dart';

import '../components/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _fireStore = FirebaseFirestore.instance;
  TextEditingController _messageTextController = TextEditingController();

  // void getMessages() async {
  //   var messages = await _fireStore.collection("messages").get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  void messageStream() {
    _fireStore.collection("messages").snapshots().listen((event) {
      for (var message in event.docs) {
        print(message.data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Implement logout functionality
                Navigator.pop(context);
                AuthService().signOut();
              }),
        ],
        title: const Text('⚡ ️Chat'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamMessage(fireStore: _fireStore),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageTextController,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality
                      _fireStore.collection("messages").add({
                        "date": DateTime.now().millisecondsSinceEpoch,
                        "sender": AuthService().getCurrentUser!.email,
                        "text": _messageTextController.text
                      });

                      _messageTextController.clear();
                    },
                    child: const Icon(Icons.send,
                        size: 30, color: kSendButtonColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamMessage extends StatelessWidget {
  const StreamMessage({
    super.key,
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection("messages").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          var messages = snapshot.data!.docs;
          List<Widget> messageBubbles = [];
          for (var message in messages) {
            var messageText = message.get("text");
            var senderText = message.get("sender");

            Widget messageBubble = MessageBubble(message: messageText, sender: senderText);
            messageBubbles.add(messageBubble);
          }

          return Expanded(
            child: ListView(
              children: messageBubbles,
            ),
          );
        } else {
          return Center(
            child: Text("Snapshot has not Data!"),
          );
        }
      },
    );
  }
}


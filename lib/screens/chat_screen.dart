import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          padding: const EdgeInsets.all(8.0),
          child: Text('data'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          print('*****************************************************');
          FirebaseFirestore.instance
              .collection('chats/cBzuAwTGzfQaNrbFb92g/messages')
              .snapshots()
              .listen((data) {
            data.docs.forEach((document) {
              print(document['text']);
            });
          });
        },
      ),
    );
  }
}

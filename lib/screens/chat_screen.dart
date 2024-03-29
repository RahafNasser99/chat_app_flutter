import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats/cBzuAwTGzfQaNrbFb92g/messages')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = streamSnapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) => Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(documents[index]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/cBzuAwTGzfQaNrbFb92g/messages')
              .add({'text': 'this was added by clicking the button.'});
        },
      ),
    );
  }
}

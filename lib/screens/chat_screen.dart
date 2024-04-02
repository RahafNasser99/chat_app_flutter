import 'package:chat_app/global/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appTheme.primaryColor,
        centerTitle: true,
        title: const Text(
          'Chats',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          DropdownButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            dropdownColor: Colors.white,
            items: const [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: <Widget>[
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8.0),
                    Text('logout'),
                  ],
                ),
              )
            ],
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut(); //destroy token
              }
            },
          )
        ],
      ),
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

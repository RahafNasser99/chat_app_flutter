import 'package:flutter/material.dart';
import 'package:chat_app/global/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/widgets/chats/messages.dart';
import 'package:chat_app/widgets/chats/new_messages.dart';

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
      body: const Column(
        children: <Widget>[
          Expanded(child: Messages()),
          NewMessage(),
        ],
      ),
    );
  }
}

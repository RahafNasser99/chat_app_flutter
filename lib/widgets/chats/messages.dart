import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('timeStamp', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (chatSnapshot.data != null) {
            final messages = chatSnapshot.data?.docs;
            return ListView.builder(
                reverse: true,
                itemCount: messages?.length,
                itemBuilder: (ctx, index) => Text(messages?[index]['text']));
          }
          return Container();
        });
  }
}

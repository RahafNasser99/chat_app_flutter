import 'package:chat_app/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/global/theme.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBBAaTl7BkjSUaBr9NqjOOCtwafrNQGyEY",
        appId: "1:1015538605937:android:b4c2dbe40e66bcb31720d0",
        messagingSenderId: "1015538605937",
        projectId: "flutter-chat-19576"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return const ChatScreen();
            }
            return const AuthScreen();
          })),
    );
  }
}

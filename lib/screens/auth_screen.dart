import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(MyUser user, bool isLogin, BuildContext ctx) async {
    UserCredential userCredential;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: user.email,
          password: user.password,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: user.email, password: user.password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'email': user.email,
          'username': user.userName,
        });
      }
    } on PlatformException catch (error) {
      var message = 'An error occurred, please check your credentials!';
      if (error.message != null) {
        message = error.message!;
      }

      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ));
      }
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(error.toString()),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ));
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(
        submitFunction: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}

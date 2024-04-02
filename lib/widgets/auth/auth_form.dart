import 'package:chat_app/global/theme.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/widgets/auth/text_form_field.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.submitFunction,
    required this.isLoading,
  });

  final void Function(
    MyUser user,
    bool isLogin,
    BuildContext ctx,
  ) submitFunction;
  final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _keyForm = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  late MyUser _user;

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();
      _user = MyUser(
          email: _userEmail.trim(),
          userName: _userName,
          password: _userPassword);
      widget.submitFunction(_user, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              child: Form(
            key: _keyForm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyTextFormField(
                  textInputType: TextInputType.emailAddress,
                  labelText: 'Email address',
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                  valueKey: 'email',
                ),
                if (!_isLogin)
                  MyTextFormField(
                    textInputType: TextInputType.emailAddress,
                    labelText: 'Username',
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 4) {
                        return 'Please enter at least 4 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value!;
                    },
                    valueKey: 'username',
                  ),
                MyTextFormField(
                  textInputType: TextInputType.emailAddress,
                  labelText: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                  valueKey: 'password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                if (widget.isLoading) const CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(appTheme.primaryColor),
                    ),
                    onPressed: _trySubmit,
                    child: Text(
                      _isLogin ? 'Login' : 'Sign up',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                if (!widget.isLoading)
                  TextButton(
                    child: Text(
                      _isLogin
                          ? 'Create a new account'
                          : 'I already have an account',
                      style: TextStyle(color: appTheme.primaryColor),
                    ),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
              ],
            ),
          )),
        ),
      ),
    );
  }
}

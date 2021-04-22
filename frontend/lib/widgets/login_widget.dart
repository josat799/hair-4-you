import 'package:flutter/material.dart';
import 'package:frontend/services/OAuth.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _askToLogin(context),
      child: Text(context.watch<UserAuth>().userState == UserState.loggedIn
          ? 'Logout'
          : 'Login'),
    );
  }

  Future<void> _askToLogin(BuildContext context) async {
    var loginInformation = {};
    return showDialog(
        context: context,
        builder: (BuildContext cx) {
          return context.watch<UserAuth>().userState == UserState.loggingIn
              ? CircularProgressIndicator()
              : Form(
                  key: _key,
                  child: SimpleDialog(
                    title: const Text('Welcome'),
                    children: [
                      TextFormField(
                        onSaved: (value) {
                          loginInformation['username'] = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please fill in your email or username';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Username/Email',
                        ),
                      ),
                      TextFormField(
                        onSaved: (value) {
                          loginInformation['password'] = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please fill in your email or username';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        obscureText: true,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState.validate()) {
                            _key.currentState.save();
                            setState(() {
                              context.read<UserAuth>().userState =
                                  UserState.loggingIn;
                            });
                            final response = await OAuth(
                              context,
                              loginInformation['username'],
                              loginInformation['password'],
                            ).requestToken();
                            print(response);
                            if (response['statusCode'] == 200) {
                              context.read<UserAuth>().token =
                                  response['message']['access_token'];
                              context.read<UserAuth>().tokenExpiryDate =
                                  response['message']['expires_in'].toString();
                              context.read<UserAuth>().userState =
                                  UserState.loggedIn;
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                );
        });
  }
}
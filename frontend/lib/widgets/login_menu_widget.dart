import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/OAuth.dart';
import 'package:frontend/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/user_auth.dart';

class LoginMenu extends StatefulWidget {
  @override
  _LoginMenuState createState() => _LoginMenuState();
}

class _LoginMenuState extends State<LoginMenu> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  Map<String, String> userCredentials = {};

  @override
  Widget build(BuildContext context) {
    UserState watchState = context.watch<UserAuth>().userState;
    UserState readState = context.read<UserAuth>().userState;

    print(watchState);
    return SizedBox.expand(
      child: watchState == UserState.loggingIn
          ? CircularProgressIndicator()
          : Column(
              children: [
                Text('Welcome'),
                _askForCredentials(),
                watchState == UserState.register
                    ? ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            _key.currentState!.save();
                            User user = User(
                              userCredentials['email']!,
                              userCredentials['name']!,
                              password: userCredentials['password']!,
                            );
                            UserService(context).createUser(user);
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Create account'),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                _key.currentState!.save();

                                context.read<UserAuth>().userState =
                                    UserState.loggingIn;

                                await OAuth(
                                  context,
                                ).login(
                                  userCredentials['username']!,
                                  userCredentials['password']!,
                                );
                                readState = UserState.loggedIn;
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Sign In'),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                context.read<UserAuth>().userState =
                                    UserState.register;
                              },
                              child: Text('Sign Up')),
                        ],
                      ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    readState = UserState.loggingIn;

                    await OAuth(
                      context,
                    ).login(
                      'josef.atoui97@gmail.com',
                      '1234',
                    );

                    readState = UserState.loggedIn;
                  },
                  child: Text('SuperLogin'),
                ),
              ],
            ),
    );
  }

  Form _askForCredentials() {
    String password = '';
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            onSaved: (value) {
              userCredentials['username'] = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill in your email or username';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Username/Email',
            ),
          ),
          context.watch<UserAuth>().userState == UserState.register
              ? TextFormField(
                  onSaved: (value) {
                    userCredentials['name'] = value!;
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill in your name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'Your Name'),
                )
              : Container(),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onSaved: (value) {
              userCredentials['password'] = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill in your email or username';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            obscureText: true,
          ),
          context.watch<UserAuth>().userState == UserState.register
              ? TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please write your password again';
                    } else if (value.contains(password)) {
                      return 'The password does not match';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Password again',
                  ),
                  obscureText: true,
                )
              // TextFormField(
              //   decoration: InputDecoration(
              //       suffix: InkWell(
              //     onTap: () => null,
              //     child: Icon(Icons.date_range_outlined),
              //   )),
              // ),

              : Container(),
        ],
      ),
    );
  }
}

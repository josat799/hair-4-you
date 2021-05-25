import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/OAuth.dart';
import 'package:frontend/services/google_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/forms_widgets/register_form.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/user_auth.dart';

class LoginMenu extends StatefulWidget {
  @override
  _LoginMenuState createState() => _LoginMenuState();
}

class _LoginMenuState extends State<LoginMenu> {
  late GlobalKey<FormState> _key;
  late UserState watchState;
  Map<String, String> userCredentials = {};

  @override
  void initState() {
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    watchState = context.watch<UserAuth>().userState;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _createUser() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      User user = User(
        email: userCredentials['email']!,
        name: userCredentials['name']!,
        password: userCredentials['password']!,
      );
      final User? createdUser = await UserService(context).createUser(user);
      if (createdUser != null) {
        await OAuth(context).login(user.email, user.password!);
      }
      Navigator.pop(context);
    }
  }

  Future<void> _signIn() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      await OAuth(
        context,
      ).login(
        userCredentials['email']!,
        userCredentials['password']!,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(watchState);
    return SizedBox.expand(
      child: watchState == UserState.loggingIn
          ? CircularProgressIndicator()
          : Column(
              children: [
                Text('Welcome'),
                _askForCredentials(),
                watchState == UserState.register
                    ? Column(
                        children: [
                          ElevatedButton(
                            onPressed: _createUser,
                            child: Text('Create account'),
                          ),
                          TextButton(
                              onPressed: () => context
                                  .read<UserAuth>()
                                  .userState = UserState.LoggedOut,
                              child: Text('Already have an account?'))
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _signIn,
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
                InkWell(
                  child: Card(
                    elevation: 8,
                    color: Colors.transparent,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                '../../assets/google/btn_google_signin_dark.png'),
                            scale: 1,
                            repeat: ImageRepeat.noRepeat,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  onTap: () async {
                    await GoogleService(context).login();
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await OAuth(
                      context,
                    ).login(
                      'josef.atoui97@gmail.com',
                      '1234',
                    );
                    Navigator.pop(context);
                  },
                  child: Text('SuperLogin'),
                ),
              ],
            ),
    );
  }

  Form _askForCredentials() {
    TextEditingController passwordController = TextEditingController();
    String password = '';

    List<Step> signInForm = [
      Step(
        content: Container(
          child: TextFormField(
            onSaved: (value) {
              userCredentials['email'] = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill in your email';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
        ),
        title: Text(''),
      ),
      Step(
        content: TextFormField(
          onChanged: (value) {
            password = value;
          },
          onSaved: (value) {
            userCredentials['password'] = value!;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a password';
            }
            return null;
          },
          decoration: const InputDecoration(
            hintText: 'Password',
          ),
          obscureText: true,
        ),
        title: Text(''),
      ),
    ];
    return Form(
      key: _key,
      child: Container(
        width: double.infinity,
        child: RegisterForm(),
        // child: Stepper(
        //   steps: context.watch<UserAuth>().userState == UserState.register
        //       ? registerForm
        //       : signInForm,
        // ),
      ),
    );
  }
}

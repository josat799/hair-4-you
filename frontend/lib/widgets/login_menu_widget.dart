import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/OAuth.dart';
import 'package:frontend/services/google_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/forms_widgets/login_form.dart';
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

  Future<void> _createUser(User user) async {
    final User? createdUser = await UserService(context).createUser(user);
    if (createdUser != null) {
      await OAuth(context).login(user.email!, user.password!);
    }
    Navigator.pop(context);
  }

  Future<void> _signIn(Map<String, dynamic> data) async {
    await OAuth(
      context,
    ).login(
      data['email']!,
      data['password']!,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: watchState == UserState.loggingIn
          ? CircularProgressIndicator()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Welcome'),
                _askForCredentials(),
                watchState == UserState.register
                    ? Column(
                        children: [
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
                              onPressed: () {
                                context.read<UserAuth>().userState =
                                    UserState.register;
                              },
                              child: Text('Sign Up'),),
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
              ],
            ),
    );
  }

  Form _askForCredentials() {
    return Form(
      key: _key,
      child: Container(
        width: double.infinity,
        child: context.watch<UserAuth>().userState == UserState.register
            ? RegisterForm(_createUser)
            : LoginForm(_signIn),
      ),
    );
  }
}

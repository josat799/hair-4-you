import 'package:flutter/material.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:frontend/screens/user_profile_screen.dart';
import 'package:frontend/services/OAuth.dart';
import 'package:frontend/services/google_service.dart';
import 'package:frontend/widgets/login_menu_widget.dart';
import 'package:frontend/widgets/profile_widgets/simple_profile.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (context.read<UserAuth>().userState == UserState.loggedIn) {
          return _showSimpleProfile();
        } else {
          return _showOption();
        }
      },
      child: Text(
        context.watch<UserAuth>().userState == UserState.loggedIn
            ? "Profile"
            : "Sign In",
      ),
    );
  }

  void _showSimpleProfile() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context,
                      UserProfileScreen.ROUTENAME +
                          '/${context.read<UserAuth>().id}');
                },
                child: Text('Show Profile')),
            ElevatedButton(
              child: Text("Sign Out"),
              onPressed: () async {
                if (context.read<UserAuth>().loggedInWithGoogle!) {
                  await GoogleService(context).logout();
                } else {
                  await OAuth(context).logout();
                }
                Navigator.pop(context);
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          content: Container(
            child: context.watch<UserAuth>().loggedInWithGoogle!
                ? Container()
                : SimpleProfile(),
          ),
        );
      },
    );
  }

  void _showOption() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (_, __) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            content: Container(
              child: LoginMenu(),
            ),
          );
        });
      },
    );
  }
}

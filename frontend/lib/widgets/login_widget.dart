import 'package:flutter/material.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:frontend/services/OAuth.dart';
import 'package:frontend/widgets/login_menu_widget.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    print(context.read<UserAuth>().userState);
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
            ? "Sign Out" //TODO: add showSimpleProfile()
            : "Sign In",
      ),
    );
  }

  void _showSimpleProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          content: Container(
            child: ElevatedButton(
              child: Text("Sign Out"),
              onPressed: () async {
                await OAuth(context).logout();
                Navigator.pop(context);
              },
            ),
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
          UserState state = context.watch<UserAuth>().userState;
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            content: SizedBox(
              height: state != UserState.register ? 250 : 400,
              child: LoginMenu(),
            ),
          );
        });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:frontend/screens/bookings_screen.dart';
import 'package:frontend/screens/index_screen.dart';
import 'package:frontend/screens/post_screen.dart';
import 'package:frontend/widgets/login_widget.dart';
import 'package:provider/provider.dart';

class CustomAppBar {
  static AppBar APPBAR(BuildContext context) {
    return AppBar(
        title: Center(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, IndexScreen.ROUTENAME);
            },
            child: Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('logotypes/logo_nr2.png'),
                    fit: BoxFit.cover),
              ),
              child: Text('Hair 4 You'),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (context.read<UserAuth>().token != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 5),
                    content: Text('You are not signed in!'),
                  ),
                );
                return;
              }
              Navigator.of(context).pushNamed(BookingsScreen.ROUTENAME);
            },
            child: Text('Bookings'),
          ),
          ElevatedButton(
            onPressed: () {
              if (context.read<UserAuth>().token != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 5),
                    content: Text('You are not signed in!'),
                  ),
                );
                return;
              }
              Navigator.of(context).pushNamed(PostScreen.ROUTENAME);
            },
            child: Text('Posts'),
          ),
          Login()
        ]);
  }
}

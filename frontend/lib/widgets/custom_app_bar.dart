import 'package:flutter/material.dart';
import 'package:frontend/screens/bookings_screen.dart';
import 'package:frontend/screens/post_screen.dart';
import 'package:frontend/widgets/login_widget.dart';

class CustomAppBar {
  static AppBar APPBAR(BuildContext context) {
    return AppBar(
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(BookingsScreen.ROUTENAME);
            },
            child: Text('Bookings')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(PostScreen.ROUTENAME);
            },
            child: Text('Posts')),
        Login()
      ],
    );
  }
}

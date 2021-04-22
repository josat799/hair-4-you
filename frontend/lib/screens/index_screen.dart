import 'package:flutter/material.dart';
import 'package:frontend/screens/user_profile_screen.dart';

import 'package:frontend/widgets/login_widget.dart';

class IndexScreen extends StatefulWidget {
  static const ROUTENAME = '/';
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Hair for You'),
        actions: [
          Login(),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('See your profile'),
          onPressed: () {
            var id = 9;
            Navigator.pushNamed(context, '${UserProfileScreen.ROUTENAME}/$id');
          },
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/blogpost_widgets/blog_post_multiple.dart';
import 'package:provider/provider.dart';
import 'package:frontend/widgets/login_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexScreen extends StatefulWidget {
  static const ROUTENAME = '/';
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  void initState() {
    checkToken();
    super.initState();
  }

  Future<void> checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token') ?? '';
    print(token);
    if (token!.isNotEmpty) {
      context.read<UserAuth>().token = token;
      context.read<UserAuth>().id = prefs.getInt('user_id');
      context.read<UserAuth>().user = await UserService(context).fetchUser(
        id: prefs.getInt('user_id'),
      );
      context.read<UserAuth>().userState = UserState.loggedIn;
    }
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
        child: BlogPostMultiple(onlyVisiable: true,),
      ),
    );
  }
}

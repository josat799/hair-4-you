import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:provider/provider.dart';

class SimpleProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = context.read<UserAuth>().user!;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: Text('${user.name}'),
          ),
          Card(
            child: Text('Phonenumber: ${user.phoneNumber}'),
          ),
          Card(
            child: Text('Last logged in: ${user.lastLoggedIn}'),
          ),
        ],
      ),
    );
  }
}

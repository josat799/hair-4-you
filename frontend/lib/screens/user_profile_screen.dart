import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/profile_widgets/profile_widget.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/user_auth.dart';

class UserProfileScreen extends StatelessWidget {
  static const ROUTENAME = '/users';
  final int _id;

  UserProfileScreen(this._id);

  Future<User> _getUser(BuildContext context) async {
    if (this._id == context.read<UserAuth>().id) {
      return await Future<User>(
          () => context.read<UserAuth>().user!);
    }
    return await UserService(context).fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: _getUser(context),
        builder: (context, snapshot) => Container(
          child: snapshot.data == null
              ? CircularProgressIndicator()
              : Center(
                  child: Profile(snapshot.data!),
                ),
        ),
      ),
    );
  }
}


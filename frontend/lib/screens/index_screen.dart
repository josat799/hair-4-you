import 'package:flutter/material.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:frontend/screens/bookings_screen.dart';
import 'package:frontend/screens/user_profile_screen.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/forms_widgets/register_form.dart';
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
    final String token = prefs.getString('token') ?? '';
    print(token);
    if (token.isNotEmpty) {
      context.read<UserAuth>().token = token;
      context.read<UserAuth>().id = prefs.getInt('user_id');
      context.read<UserAuth>().user = await UserService(context).fetchUser();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              child: Text('See your profile'),
              onPressed: () {
                if (context.read<UserAuth>().userState != UserState.loggedIn) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('You are not logged in'),
                  ));
                  return;
                }
                var id = context.read<UserAuth>().id;
                Navigator.pushNamed(
                    context, '${UserProfileScreen.ROUTENAME}/$id');
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (context.read<UserAuth>().userState !=
                      UserState.loggedIn) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('You are not logged in'),
                    ));
                    return;
                  }
                  Navigator.pushNamed(context, '${BookingsScreen.ROUTENAME}');
                },
                child: Text('See all bookings'))
          ],
        ),
      ),
    );
  }
}

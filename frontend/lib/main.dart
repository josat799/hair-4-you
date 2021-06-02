import 'package:flutter/material.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:frontend/screens/blog_post_screen.dart';
import 'package:frontend/screens/bookings_screen.dart';
import 'package:frontend/screens/index_screen.dart';
import 'package:frontend/screens/unknow_screen.dart';
import 'package:frontend/screens/user_profile_screen.dart';
import 'package:frontend/services/OAuth.dart';
import 'package:frontend/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserAuth('com.hair_for_you.web')),
      ],
      child: Hair4You(),
    ),
  );
}

Route<dynamic> _routes(RouteSettings settings) {
  var id;

  var uri = Uri.parse(settings.name!);
  if (uri.pathSegments.length == 2) {
    id = uri.pathSegments[1];
  }
  if (settings.name == IndexScreen.ROUTENAME) {
    return MaterialPageRoute(
        builder: (context) => IndexScreen(), settings: settings);
  } else if (settings.name!.startsWith(UserProfileScreen.ROUTENAME)) {
    return MaterialPageRoute(
      builder: (context) => UserProfileScreen(int.parse(id)),
      settings: settings,
    );
  } else if (settings.name == BookingsScreen.ROUTENAME) {
    return MaterialPageRoute(
      builder: (context) => BookingsScreen(),
      settings: settings,
    );
  } else if (settings.name == BlogPostScreen.ROUTENAME) {
    return MaterialPageRoute(
        builder: (context) => BlogPostScreen(), settings: settings);
  } else {
    return MaterialPageRoute(
      builder: (context) => UnknowScreen(),
      settings: settings,
    );
  }
}

class Hair4You extends StatelessWidget {
  Future<void> checkToken(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      bool authorized = await OAuth(context).verifyToken(token);
      if (authorized) {
        context.read<UserAuth>().token = token;
        context.read<UserAuth>().id = prefs.getInt('user_id');
        try {
          context.read<UserAuth>().user = await UserService(context).fetchUser(
            id: prefs.getInt('user_id'),
          );
          context.read<UserAuth>().userState = UserState.loggedIn;
        } on Exception catch (e) {
          // TODO
        }
      }
    } else {
      context.read<UserAuth>().userState = UserState.LoggedOut;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkToken(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hair for you',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.yellowAccent,
      ),
      onGenerateRoute: (settings) => _routes(settings),
    );
  }
}

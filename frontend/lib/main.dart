import 'package:flutter/material.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:frontend/screens/index_screen.dart';
import 'package:frontend/screens/unknow_screen.dart';
import 'package:frontend/screens/user_profile_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserAuth('com.hair4you.com')),
      ],
      child: Hair4You(),
    ),
  );
}

Route<dynamic> _routes(RouteSettings settings) {
  var id;

  var uri = Uri.parse(settings.name);
  if (uri.pathSegments.length == 2) {
    id = uri.pathSegments[1];
  }
  if (settings.name == IndexScreen.ROUTENAME) {
    return MaterialPageRoute(
        builder: (context) => IndexScreen(), settings: settings);
  } else if (settings.name.startsWith(UserProfileScreen.ROUTENAME)) {
    return MaterialPageRoute(
      builder: (context) => UserProfileScreen(int.parse(id)),
      settings: settings,
    );
  } else {
    return MaterialPageRoute(
      builder: (context) => UnknowScreen(),
      settings: settings,
    );
  }
}

class Hair4You extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

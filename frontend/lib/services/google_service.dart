import 'package:flutter/material.dart';
import 'package:frontend/providers/user_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleService {
  late GoogleSignInAccount account;
  final BuildContext context;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '473268649506-3f62jgvrqduv4lsd9q77c8ile8vsjqbd.apps.googleusercontent.com',
    scopes: <String>[
      'email',
    ],
  );

  GoogleService(this.context);

  login() async {
    context.read<UserAuth>().userState = UserState.loggingIn;
    try {
      await _googleSignIn.signIn();

      account = _googleSignIn.currentUser!;
      context.read<UserAuth>().userState = UserState.loggedIn;
      context.read<UserAuth>().loggedInWithGoogle = true;
    } catch (error) {
      context.read<UserAuth>().userState = UserState.LoggedOut;
    }
  }

  logout() async {
    context.read<UserAuth>().userState = UserState.loggingOut;
    try {
      await _googleSignIn.disconnect();
      if (!(await _googleSignIn.isSignedIn())) {
        context.read<UserAuth>().userState = UserState.LoggedOut;
        context.read<UserAuth>().loggedInWithGoogle = false;
      }
    } catch (error) {
      context.read<UserAuth>().userState = UserState.loggedIn;
    }
  }
}

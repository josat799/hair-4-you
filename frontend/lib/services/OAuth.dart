import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:frontend/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OAuth {
  final BuildContext context;

  OAuth(this.context);

  Future<void> logout() async {
    context.read<UserAuth>().userState = UserState.loggingOut;
    final prefs = await SharedPreferences.getInstance();
    context.read<UserAuth>().id = null;
    context.read<UserAuth>().token = null;
    context.read<UserAuth>().tokenExpiryDate = null;
    context.read<UserAuth>().user = null;

    prefs.clear();

    if (prefs.getKeys().isEmpty) {
      context.read<UserAuth>().userState = UserState.LoggedOut;
    }
  }

  Future<Map<String, dynamic>> _requestToken(
      String username, String password) async {
    final String clientID = "${context.read<UserAuth>().clientID}";
    String body = "username=$username&password=$password&grant_type=password";

    final String clientCredentials =
        const Base64Encoder().convert("$clientID:".codeUnits);

    final response = await http.post(
      Uri.http("localhost:8888", "/login"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Basic $clientCredentials",
      },
      body: body,
    );

    return {
      "message": jsonDecode(response.body),
      "statusCode": response.statusCode
    };
  }

  Future<bool> verifyGoogle(String token) async {
    final String clientID = "${context.read<UserAuth>().clientID}";
    String body = "google_token=$token";
    final String clientCredentials =
        const Base64Encoder().convert("$clientID:".codeUnits);

    final Response response = await http.post(
      Uri.http('localhost:8888', "/google"),
      body: body,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Basic $clientCredentials",
      },
    );

    return response.statusCode == 200;
  }

  Future<void> loginWithGoogle() async {}

  Future<void> login(String username, String password) async {
    context.read<UserAuth>().userState = UserState.loggingIn;
    final Map<String, dynamic> response =
        await _requestToken(username, password);
    if (response['statusCode'] == 200) {
      context.read<UserAuth>().token =
          response['message']['access_token'].toString();

      context.read<UserAuth>().tokenExpiryDate =
          response['message']['expires_in'].toString();

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response['message']['access_token']);
      prefs.setString(
          'token_expires', response['message']['expires_in'].toString());

      final User user = await UserService(context).fetchUser(email: username);
      context.read<UserAuth>().id = user.id;
      context.read<UserAuth>().user = user;
      prefs.setInt('user_id', user.id!);
      context.read<UserAuth>().userState = UserState.loggedIn;
      return;
    }
    context.read<UserAuth>().userState = UserState.LoggedOut;
  }
}

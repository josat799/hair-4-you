import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:frontend/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OAuth {
  final BuildContext context;
  final String username, password;

  OAuth(this.context, this.username, this.password);

  Future<Map<String, dynamic>> _requestToken() async {
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

  Future<void> login() async {
    final Map<String, dynamic> response = await _requestToken();
    if (response['statusCode'] == 200) {
      context.read<UserAuth>().token = response['message']['access_token'];
      context.read<UserAuth>().tokenExpiryDate =
          response['message']['expires_in'].toString();
      context.read<UserAuth>().userState = UserState.loggedIn;

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response['message']['access_token']);
      prefs.setString('token_expires', response['message']['expires_in']);

      final user = await UserService(context)
          .fetchUser(email: 'josef.atoui97@gmail.com');
      context.read<UserAuth>().id = user['id'];
      context.read<UserAuth>().user = user;
      prefs.setString('user_id', user['id']);
    }
  }
}

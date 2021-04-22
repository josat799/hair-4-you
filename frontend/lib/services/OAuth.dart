import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OAuth {
  final BuildContext context;
  final String username, password;

  OAuth(this.context, this.username, this.password);

  Future<Map<String, dynamic>> requestToken() async {
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
}
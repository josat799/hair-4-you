import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserService {
  final BuildContext context;

  UserService(this.context);

  Future<User?> createUser(User user) async {
    String encodedUser = jsonEncode(user.toJson());
    final String clientID = "${context.read<UserAuth>().clientID}";
    final String clientCredentials =
        const Base64Encoder().convert("$clientID:".codeUnits);

    try {
      http.Response response = await http.post(
          Uri.http('localhost:8888', '/register'),
          headers: {
            "Authorization": "Basic $clientCredentials",
            'content-type': 'application/json'
          },
          body: encodedUser);

      return response.statusCode == 200
          ? User.fromJson(jsonDecode((response.body)))
          : null;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<User?> fetchUser({String? email, int? id}) async {
    String path;
    Map<String, String> params = {};
    if (id == null && email == null) {
      throw Error();
    } else if (email == null) {
      path = "/users/$id";
    } else {
      path = "/users";
      params['email'] = email;
    }

    String token = context.read<UserAuth>().token;
    try {
      http.Response response = await http.get(
          Uri.http("localhost:8888", path, params.isNotEmpty ? params : null),
          headers: {'Authorization': 'Bearer $token'});
          
      final decodedBody = jsonDecode(response.body);
      if (decodedBody is List<dynamic>) {
        return User.fromJson(decodedBody[0]);
      } else {
        return User.fromJson(decodedBody);
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}

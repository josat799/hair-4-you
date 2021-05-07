import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
//import 'package:models/models.dart';

class UserService {
  final BuildContext context;

  UserService(this.context);

  Future<User> fetchUser({String? email}) async {
    int id = context.read<UserAuth>().id!;
    String path;
    Map<String, String> params = {};

    if (id == null && email.isNotEmpty) {
      path = "/users";
      params['email'] = email;
    } else {
      path = "/users/$id";
    }

    String token = context.read<UserAuth>().token;
    var response = await http.get(
        Uri.http("localhost:8888", path, params.isNotEmpty ? params : null),
        headers: {'Authorization': 'Bearer $token'});

    final decodedBody = jsonDecode(response.body);
    User fetchedUser = decodedBody[0] == null
        ? User.fromJson(decodedBody)
        : User.fromJson(decodedBody[0]);

    print(fetchedUser);
    return fetchedUser;
  }
}

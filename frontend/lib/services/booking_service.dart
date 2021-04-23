import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class BookingService {
  final BuildContext context;

  BookingService(this.context);

  Future<List<Map<String, dynamic>>> fetchBookings() async {
    String token = context.read<UserAuth>().token;
    var response = await http.get(Uri.http("localhost:8888", '/bookings'),
        headers: {'Authorization': 'Bearer $token'});

    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }
}

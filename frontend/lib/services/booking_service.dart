import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/booking.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class BookingService {
  final BuildContext context;

  BookingService(this.context);

  Future<Booking?> fetchBookingByID(int bookingID) async {
    String token = context.read<UserAuth>().token;
    http.Response response;

    try {
      response = await http.get(
          Uri.http("localhost:8888", '/bookings/${bookingID}'),
          headers: {'Authorization': 'Bearer $token'});
    } on Exception catch (e) {
      return null;
    }

    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);

      return Booking.fromJson(decodedBody);
    } else if (response.statusCode == 404) {
      throw Exception('Could not find the booking');
    } else if (response.statusCode == 401) {
      throw Exception('You are not logged in!');
    } else {
      throw Exception('Something went wrong, try again later!');
    }
  }

  Future<void> deleteBookingByID(int bookingID) async {
    String token = context.read<UserAuth>().token;
    http.Response response;

    try {
      response = await http.delete(
          Uri.http("localhost:8888", '/bookings/${bookingID}'),
          headers: {'Authorization': 'Bearer $token'});
    } on Exception catch (e) {
      return null;
    }

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 404) {
      throw Exception('Could not find the booking');
    } else if (response.statusCode == 401) {
      throw Exception('You are not logged in!');
    } else {
      throw Exception('Something went wrong, try again later!');
    }
  }

  Future<List<Booking>> fetchBookings() async {
    String token = context.read<UserAuth>().token;
    http.Response response;

    try {
      response = await http.get(Uri.http("localhost:8888", '/bookings'),
          headers: {'Authorization': 'Bearer $token'});
    } on Exception catch (e) {
      return [];
    }

    if (response.statusCode == 200) {
      dynamic decodedBody = json.decode(response.body);
      Iterable<dynamic> l = decodedBody;

      return List<Booking>.from((l.map((booking) {
        return Booking.fromJson(booking);
      })));
    } else if (response.statusCode == 404) {
      throw Exception('Could not find the post');
    } else if (response.statusCode == 401) {
      throw Exception('You are not logged in!');
    } else {
      throw Exception('Something went wrong, try again later!');
    }
  }

  Future<void> updateBooking(Booking booking,
      {bool? addCustomer, bool? addHairdresser}) async {
    String token = context.read<UserAuth>().token;
    http.Response response;
    String path = '/bookings/${booking.id}';
    if (addCustomer != null && addCustomer) {
      path += '/add/customer';
    } else if (addHairdresser != null && addHairdresser) {
      path += '/add/hairdresser';
    }

    try {
      var body = jsonEncode(booking.toJson());

      response = await http.put(Uri.http("localhost:8888", path),
          headers: {'Authorization': 'Bearer $token'}, body: body);
    } on Exception catch (e) {
      print(e);
      return;
    }

    if (response.statusCode == 404) {
      throw Exception('Could not find the booking');
    } else if (response.statusCode == 401) {
      throw Exception('You are not logged in!');
    }
  }

  Future<void> addBooking(Booking booking) async {
    String token = context.read<UserAuth>().token;
    http.Response response;

    final body = jsonEncode(booking.toJson());

    try {
      response = await http.post(Uri.http("localhost:8888", '/bookings'),
          headers: {'Authorization': 'Bearer $token'}, body: body);
    } on Exception catch (e) {
      return;
    }

    if (response.statusCode == 401) {
      throw Exception('You are not logged in!');
    }
  }
}

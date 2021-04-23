import 'package:flutter/material.dart';
import 'package:frontend/services/booking_service.dart';

class BookingsScreen extends StatelessWidget {
  static const ROUTENAME = "/bookings";

  Future<List<Map<String, dynamic>>> _getBookings(BuildContext context) async {
    return await BookingService(context).fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _getBookings(context),
      builder: (context, snapshot) => Center(
        child: snapshot.data == null
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) => Card(
                  child: Text('${snapshot.data[index]['name']}'),
                ),
              ),
      ),
    );
  }
}

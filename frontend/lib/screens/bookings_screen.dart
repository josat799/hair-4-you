import 'package:flutter/material.dart';
import 'package:frontend/services/booking_service.dart';

class BookingsScreen extends StatefulWidget {
  static const ROUTENAME = "/bookings";

  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  Future<List<dynamic>> _futureList;

  @override
  initState() {
    super.initState();
    _futureList = BookingService(context).fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: _futureList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) => Center(
                child: Card(
                  child: Text('${snapshot.data[index]['title']}'),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

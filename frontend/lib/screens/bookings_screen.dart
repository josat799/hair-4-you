import 'package:flutter/material.dart';
import 'package:frontend/models/booking.dart';
import 'package:frontend/widgets/booking_widgets/selectable_calendar.dart';
import 'package:frontend/widgets/booking_widgets/single_booking.dart';
import 'package:frontend/widgets/custom_app_bar.dart';

class BookingsScreen extends StatefulWidget {
  static const ROUTENAME = "/bookings";

  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  late List<Booking> _bookings;

  void getBookings(List<Booking> bookings) {
    setState(() {
      _bookings = bookings;
    });
  }

  @override
  void initState() {
    _bookings = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: CustomAppBar.APPBAR(context),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Container(
                width: _bookings.isEmpty ? 500 : _mediaQueryData.size.width / 2,
                child: SelectableCalendar(
                  updateFrequency: 10,
                  callBack: getBookings,
                )),
          ),
          _bookings.isEmpty
              ? SizedBox()
              : Container(
                  width: _mediaQueryData.size.width / 2,
                  child: ListView.builder(
                      itemCount: _bookings.length,
                      itemBuilder: (ctx, index) => SingleBooking(
                            booking: _bookings.elementAt(index),
                          ),),
                )
        ],
      ),
    );
  }
}

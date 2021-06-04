import 'package:flutter/material.dart';
import 'package:frontend/models/booking.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_auth.dart';
import 'package:frontend/services/booking_service.dart';
import 'package:provider/provider.dart';

class SingleBooking extends StatefulWidget {
  Booking booking;

  SingleBooking({required this.booking});

  @override
  _SingleBookingState createState() => _SingleBookingState();
}

class _SingleBookingState extends State<SingleBooking> {
  void _book() async {
    if (context.read<UserAuth>().user!.role == Role.customer) {
      await BookingService(context)
          .updateBooking(widget.booking, addCustomer: true);
    } else {
      await BookingService(context)
          .updateBooking(widget.booking, addHairdresser: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.booking.title!),
      trailing: IconButton(
        onPressed: () => _book(),
        icon: Icon(
          Icons.book_rounded,
          color: Colors.green,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:frontend/models/booking.dart';
import 'package:frontend/services/booking_service.dart';

class SelectableCalendar extends StatefulWidget {
  final int updateFrequency;
  final double? height;
  final double? width;
  final Function(List<Booking> bookings)? callBack;

  SelectableCalendar({
    required this.updateFrequency,
    this.height,
    this.width,
    this.callBack,
  });
  @override
  _SelectableCalendarState createState() => _SelectableCalendarState();
}

class _SelectableCalendarState extends State<SelectableCalendar> {
  DateTime _targetDateTime = DateTime.now();

  late Stream<List<Booking>> _stream;
  @override
  void initState() {
    _stream = _fetchBookings();
    super.initState();
  }

  Stream<List<Booking>> _fetchBookings() async* {
    yield* Stream.periodic(
      Duration(seconds: widget.updateFrequency),
      (_) async => await BookingService(context).fetchBookings(),
    ).asyncMap((event) async => await event);
  }

  void addData(List<Booking> bookings) {
    bookings.forEach((booking) {
      for (Booking event in _markedDateMap.getEvents(booking.date)) {
        if (event.id == booking.id) {
          return;
        }
      }

      if (_markedDateMap.events.containsKey(DateTime(booking.startTime!.year,
          booking.startTime!.month, booking.startTime!.day))) {
        _markedDateMap.events.update(
          DateTime(booking.startTime!.year, booking.startTime!.month,
              booking.startTime!.day),
          (value) => value..add(booking),
        );
      } else {
        _markedDateMap.add(
            DateTime(booking.startTime!.year, booking.startTime!.month,
                booking.startTime!.day),
            booking);
      }
    });
  }

  EventList<Booking> _markedDateMap = new EventList<Booking>(events: {});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Booking>>(
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return Center(child: LinearProgressIndicator());
        } else {
          addData(snapshot.data!);
          return Container(
            height: widget.height,
            width: widget.width,
            child: CalendarCarousel<Booking>(
              daysHaveCircularBorder: false,
              onDayPressed: (date, events) {
                setState(() {
                  this._targetDateTime = date;
                });
                if (widget.callBack != null) {
                  widget.callBack!(events);
                }
              },
              selectedDateTime: _targetDateTime,
              isScrollable: false,
              locale: 'sv',
              headerText: "Avaiable bookings",
              markedDatesMap: _markedDateMap,
              minSelectedDate: DateTime.now().subtract(Duration(days: 1)),
              todayButtonColor: Colors.transparent,
              markedDateShowIcon: true,
              markedDateMoreShowTotal: true,
              markedDateIconBuilder: (event) {
                return Icon(Icons.calendar_today_outlined);
              },
              todayBorderColor: Colors.transparent,
              todayTextStyle: TextStyle(color: Colors.black),
            ),
          );
        }
      },
      stream: _stream,
    );
  }
}

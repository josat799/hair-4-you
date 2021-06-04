import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:frontend/models/user.dart';

class Booking extends Event {
  int? id;
  DateTime? createdAt;
  String? title;
  String? description;
  DateTime? lastEdited;
  DateTime? startTime;
  int? bookedAmountOfCustomers;
  int? amountOfCustomers;
  Duration? duration;
  List<User>? customers;
  List<User>? hairdressers;

  Booking({
    this.id,
    this.startTime,
    this.title,
    this.createdAt,
    this.duration,
    this.lastEdited,
    this.description = 'Missing',
    this.amountOfCustomers = 0,
    this.bookedAmountOfCustomers = 0,
  }) : super(
          date: DateTime(
            startTime!.year,
            startTime.month,
            startTime.day,
          ),
        );

  Booking.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        createdAt = DateTime.parse(json['createdAt']),
        lastEdited = json['lastEdited'] == null
            ? null
            : DateTime.parse(json['lastEdited']),
        startTime = DateTime.parse(json['startTime']),
        duration = Duration(minutes: json['duration'] ?? null),
        amountOfCustomers = json['amountOfCustomers'],
        bookedAmountOfCustomers = json['bookedAmountOfCustomers'],
        customers = List<User>.from(
          (json['bookingCustomer'] as List<dynamic>)
              .expand(
                (element) => {
                  User.fromJson(
                    element['customer'],
                  ),
                },
              )
              .toList(),
        ),
        hairdressers = List<User>.from(
          (json['bookingHairdresser'] as List<dynamic>)
              .expand(
                (element) => {
                  User.fromJson(
                    element['hairdresser'],
                  ),
                },
              )
              .toList(),
        ),
        super(
          date: DateTime(
              DateTime.parse(json['startTime']).year,
              DateTime.parse(json['startTime']).month,
              DateTime.parse(json['startTime']).day),
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startTime': startTime.toString(),
      'description': description,
      'duration': duration!.inMinutes.toInt(),
      'amountOfCustomers': amountOfCustomers,
    };
  }
}

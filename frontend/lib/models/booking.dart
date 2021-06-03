import 'package:frontend/models/user.dart';

class Booking {
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
  });

  Booking.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        createdAt = DateTime.parse(json['createdAt']),
        lastEdited = DateTime.parse(json['lastEdited']),
        startTime = DateTime.parse(json['startTime']),
        duration = Duration(minutes: json['duration']),
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
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startTime': startTime,
      'description': description,
      'duration': duration.toString(),
      'amountOfCustomers': amountOfCustomers,
    };
  }
}

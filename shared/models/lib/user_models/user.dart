import 'package:models/booking_models/booking.dart';

enum userType {
  customer,
  hairdresser,
  admin,
  owner,
}

class User {
  final String id;
  String name;
  String phoneNumber;
  final DateTime birthDate;
  final DateTime accountCreated;
  DateTime lastLoggedIn;
  List<String> emails;
  List<userType> userTypes;
  List<Booking> bookings;

  User({
    this.id,
    this.name,
    this.emails,
    this.birthDate,
    this.phoneNumber,
    this.accountCreated,
    this.lastLoggedIn,
    this.userTypes = const [userType.customer],
    this.bookings = const [],
  });
}

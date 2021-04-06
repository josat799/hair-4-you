import '../booking_models/booking.dart';

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
    required this.id,
    required this.name,
    required this.emails,
    required this.birthDate,
    required this.phoneNumber,
    required this.accountCreated,
    required this.lastLoggedIn,
    this.userTypes = const [userType.customer],
    this.bookings = const [],
  });
}

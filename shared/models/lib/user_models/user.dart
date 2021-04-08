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
  String email;
  String? phoneNumber;
  final DateTime? birthDate;
  final DateTime createdAt;
  DateTime lastLoggedIn;
  List<userType> userTypes;
  List<Booking>? bookings;

  User({
    required this.id,
    required this.createdAt,
    required this.birthDate,
    required this.email,
    required this.name,
    required this.lastLoggedIn,
    this.phoneNumber,
    this.bookings = const [],
    this.userTypes = const [userType.customer],
  }) {
    phoneNumber = 'Missing';
  }

}

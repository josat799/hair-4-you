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

  void addBooking(Booking booking) => bookings?.add(booking);

  void addMultipleBookings(List<Booking> bookings) =>
      this.bookings?.addAll(bookings);

  void removeBookin(Booking booking) =>
      bookings?.removeWhere((element) => element.id == booking.id);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        birthDate = json['birthDate'] ?? '',
        createdAt = json['accountCreated'],
        phoneNumber = json['phoneNumber'],
        name = json['name'],
        email = json['email'],
        userTypes = json['userTypes'],
        lastLoggedIn = json['lastLoggedIn'],
        bookings = json['bookings'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'birthDate': birthDate,
      'accountCreated': createdAt,
      'phoneNumber': phoneNumber,
      'email': email,
      'userTypes': userTypes,
      'lastLoggedIn': lastLoggedIn,
      'bookings': bookings,
    };
  }

}

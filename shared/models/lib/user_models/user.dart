import 'package:models/models.dart';

enum userType {
  customer,
  hairdresser,
  admin,
  owner,
}

class User {
  final int id;
  String name;
  String email;
  String? phoneNumber;
  final DateTime birthDate;
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
    bookings = [];
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
      'birthDate': birthDate.toIso8601String(),
      'accountCreated': createdAt.toIso8601String(),
      'phoneNumber': phoneNumber,
      'email': email,
      'userTypes': userTypes.map((_userType) => _userType.toString()).toList(),
      'lastLoggedIn': lastLoggedIn.toIso8601String(),
      'bookings': bookings?.map((booking) => booking.id).toList(),
    };
  }

  @override
  String toString() {
    return '''
    Hi $name your id is $id. 
    Your birth date is ${birthDate.toString()} 
    and you created this account ${createdAt.toIso8601String()}
    Your phonenumber is $phoneNumber and your emails is $email.
    You're $userTypes and your bookings are $bookings. 
    Last seen ${lastLoggedIn.toIso8601String()}.
    ''';
  }
}

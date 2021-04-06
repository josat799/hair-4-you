import '../user_models/user.dart';

class Booking {
  final String id;
  final DateTime createdAt;
  String title;
  String description;
  DateTime lastEdited;
  DateTime startTime;
  String endTime;
  List<User> hairDressers = [];
  List<User> customers = [];
  int amountOfCustomers;

  Booking({
    required this.id,
    required this.startTime,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.endTime,
    required this.lastEdited,
    required this.amountOfCustomers,
    List<User> hairDressers = const [],
    List<User> customers = const [],
  }) {
    hairDressers.isEmpty ? null : this.hairDressers = hairDressers;
    customers.isEmpty ? null : this.customers = customers;
  }
}

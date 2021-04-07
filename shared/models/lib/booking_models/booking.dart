import 'package:models/user_models/user.dart';

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

  Booking(
    this.id,
    this.startTime,
    this.title,
    this.description,
    this.createdAt,
    this.endTime,
    this.lastEdited,
    this.amountOfCustomers, {
    List<User> hairDressers = const [],
    List<User> customers = const [],
  }) {
    hairDressers.isEmpty ? null : this.hairDressers = hairDressers;
    customers.isEmpty ? null : this.customers = customers;
  }
}

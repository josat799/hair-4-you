import 'package:models/models.dart';

class Booking {
  final int id;
  final DateTime createdAt;
  String title;
  String? description;
  DateTime lastEdited;
  DateTime startTime;
  Duration duration;
  List<User>? hairDressers = [];
  List<User>? customers = [];
  int? amountOfCustomers;

  Booking({
    required this.id,
    required this.startTime,
    required this.title,
    required this.createdAt,
    required this.duration,
    required this.lastEdited,
    this.description = 'Missing',
    this.amountOfCustomers = 0,
    List<User>? hairDressers,
    List<User>? customers,
  }) {
    hairDressers = [];
    customers = [];
  }

  Set<String> getDuration() {
    return <String>{startTime.toString(), startTime.add(duration).toString()};
  }

  Booking.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = json['createdAt'],
        startTime = json['startTime'],
        title = json['title'],
        description = json['description'],
        duration = json['duration'],
        lastEdited = json['lastEditited'],
        amountOfCustomers = json['amountOfCustomers'],
        hairDressers = json['hairDressers'],
        customers = json['customers'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt,
      'startTime': startTime,
      'description': description,
      'duration': duration,
      'amountOfCustomers': amountOfCustomers,
      'lastEdited': lastEdited,
      'hairDressers': hairDressers,
      'customers': customers,
    };
  }

  @override
  String toString() {
    return '''
    Id $id - $title. 
    Description: $description.
    Created at ${createdAt.toIso8601String()} and last editied $lastEdited.
    The booking start at ${startTime.toIso8601String()} and ends 
    ${startTime.add(duration).toIso8601String()}, the duration is $duration.
    This booking allows for $amountOfCustomers people, and the hairdressers are 
    $hairDressers and the customers are $customers.
    ''';
  }
}

import 'package:models/models.dart';

class ManagedBooking extends ManagedObject<Booking> implements Booking {}

@Table(name: 'Bookings')
class Booking {
  @primaryKey
  final int id;

  @Column(nullable: false)
  final DateTime createdAt;

  @Column(nullable: false)
  String title;

  @Column(nullable: true)
  String description;

  @Column(nullable: true)
  DateTime lastEdited;

  @Column(nullable: false)
  DateTime startTime;

  @Column(nullable: false, databaseType: ManagedPropertyType.integer)
  Duration duration;

  // @Column(nullable: true)
  // List<User> hairDressers = [];

  ManagedSet<ManagedBookingCustomer> bookingCustomer;

  ManagedSet<ManagedBookingHairdresser> bookingHairdresser;

  //@Column(nullable: true)
  //List<User> customers = [];

  @Column(nullable: true)
  int amountOfCustomers;

  Booking({
    this.id,
    this.startTime,
    this.title,
    this.createdAt,
    this.duration,
    this.lastEdited,
    this.description = 'Missing',
    this.amountOfCustomers = 0,
    List<User> hairDressers,
    List<User> customers,
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
        //hairDressers = json['hairDressers'],
        bookingCustomer = json['customers'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'description': description,
      'duration': duration.toString(),
      'amountOfCustomers': amountOfCustomers,
      'lastEdited': lastEdited.toIso8601String(),
      //'hairDressers': hairDressers.map((user) => user.id).toList(),
      'customers': bookingCustomer.map((user) => user.id).toList(),
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
    and the customers are $bookingCustomer.
    ''';
  }
}

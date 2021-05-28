import 'package:backend/backend.dart';

enum userType {
  customer,
  hairdresser,
  admin,
  owner,
}

class ManagedUser extends ManagedObject<User>
    implements User, ManagedAuthResourceOwner<User> {
  @Serialize(input: true, output: false)
  String password;
}

@Table(name: 'Users')
class User extends ResourceOwnerTableDefinition {
  @Column(nullable: false)
  String name;

  @Column(nullable: false, unique: true)
  String email;

  @Column(nullable: true)
  String phoneNumber;

  @Column(nullable: true)
  final DateTime birthDate;

  @Column(nullable: false)
  DateTime createdAt;

  @Column(nullable: true)
  DateTime lastLoggedIn;

  ManagedSet<ManagedBlogPost> posts;

  ManagedSet<ManagedBookingCustomer> bookingCustomer;

  ManagedSet<ManagedBookingHairdresser> bookingHairdresser;
// List<Booking> bookings;
  @Column(nullable: true)
  userType role;

  User({
    this.createdAt,
    this.birthDate,
    this.email,
    this.name,
    this.lastLoggedIn,
    this.phoneNumber,
    this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthDate': birthDate.toIso8601String(),
      'accountCreated': createdAt.toIso8601String(),
      'phoneNumber': phoneNumber,
      'email': email,
      'lastLoggedIn': lastLoggedIn.toIso8601String(),
      'bookings': bookingCustomer.map((booking) => booking.id).toList(),
    };
  }

  @override
  String toString() {
    return '''
    Hi $name your id is. 
    Your birth date is ${birthDate.toString()} 
    and you created this account ${createdAt.toIso8601String()}
    Your phonenumber is $phoneNumber and your emails is $email.
    You're $role and your bookings are $bookingCustomer. 
    Last seen ${lastLoggedIn.toIso8601String()}.
    ''';
  }
}

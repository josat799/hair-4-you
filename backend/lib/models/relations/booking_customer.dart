import 'package:backend/backend.dart';

class ManagedBookingCustomer extends ManagedObject<BookingCustomer>
    implements BookingCustomer {}

@Table(name: 'BookingsCustomers')
class BookingCustomer {
  @primaryKey
  int id;

  @Relate(#bookingCustomer)
  ManagedBooking booking;

  @Relate(#bookingCustomer)
  ManagedUser customer;
}

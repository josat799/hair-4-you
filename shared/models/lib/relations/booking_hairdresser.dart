import 'package:models/models.dart';

class ManagedBookingHairdresser extends ManagedObject<BookingHairdresser>
    implements BookingHairdresser {}

@Table(name: 'BookingsHairdressers')
class BookingHairdresser {
  @Column(primaryKey: true)
  int id;

  @Relate(#bookingHairdresser)
  ManagedUser hairDressers;

  @Relate(#bookingHairdresser)
  ManagedBooking bookings;
}

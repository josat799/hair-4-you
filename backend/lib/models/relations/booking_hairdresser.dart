import 'package:backend/backend.dart';

class ManagedBookingHairdresser extends ManagedObject<BookingHairdresser>
    implements BookingHairdresser {}

@Table(name: 'BookingsHairdressers')
class BookingHairdresser {
  @Column(primaryKey: true)
  int id;

  @Relate(#bookingHairdresser)
  ManagedUser hairDresser;

  @Relate(#bookingHairdresser)
  ManagedBooking booking;
}

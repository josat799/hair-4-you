import 'package:backend/backend.dart';

class BookingController extends ResourceController {
  BookingController(this.context);

  final ManagedContext context;

  @Operation.get('id')
  Future<Response> getBookingByID(@Bind.path('id') int id) async {
    final query = Query<ManagedBooking>(context)
      ..where((booking) => booking.id).equalTo(id);

    final booking = await query.fetchOne();

    if (booking == null) {
      return Response.notFound();
    }
    return Response.ok(booking);
  }

  @Operation.get()
  Future<Response> getBooking() async {
    final query = Query<ManagedBooking>(context)
      ..join(set: (booking) => booking.bookingCustomer)
          .join<ManagedUser>(
              object: (bookingCustomer) => bookingCustomer.customer)
          .returningProperties((customer) => [
                customer.name,
              ])
      ..join(set: (booking) => booking.bookingHairdresser)
          .join<ManagedUser>(
              object: (bookingHairDresser) => bookingHairDresser.hairDresser)
          .returningProperties((hairdresser) => [
                hairdresser.name,
              ]);
    return Response.ok(await query.fetch());
  }

  @Operation.post()
  Future<Response> addBooking(
      @Bind.body(ignore: ["id"]) ManagedBooking booking) async {
    final query = Query<ManagedBooking>(context)..values = booking;
    return Response.ok(await query.insert());
  }

  @Operation.put('id')
  Future<Response> updateBooking(
    @Bind.path('id') int id,
    @Bind.body(ignore: ["id"]) ManagedBooking _booking,
  ) async {
    final bookingQuery = Query<ManagedBooking>(context)
      ..where((booking) => booking.id).equalTo(id);

    final userQuery = Query<ManagedUser>(context)
      ..where((user) => user.id).equalTo(request.authorization.ownerID);

    final ManagedBooking booking = await bookingQuery.fetchOne();
    final ManagedUser user = await userQuery.fetchOne();

    if (request.path.segments.contains('customer')) {
      if (user.role != userType.customer) {
        return Response.conflict(
          body: {'message': 'You must be a customer!'},
        );
      }
      if (!_booking.canAddBooking()) {
        return Response.conflict(
          body: {'message': 'The amount of customers are full!'},
        );
      }

      final ManagedBookingCustomer bookingCustomerRelation =
          ManagedBookingCustomer()
            ..customer = user
            ..booking = booking;

      final relationQuery = Query<ManagedBookingCustomer>(context)
        ..values = bookingCustomerRelation;

      bookingQuery.values.bookedAmountOfCustomers++;

      await relationQuery.insert();
    } else if (request.path.segments.contains('hairdresser')) {
      if (user.role != userType.customer) {
        return Response.conflict(
          body: {'message': 'You must be a hairdresser!'},
        );
      }
      final ManagedBookingHairdresser bookingHairdresserRelation =
          ManagedBookingHairdresser()
            ..hairDresser = user
            ..booking = booking;

      final relationQuery = Query<ManagedBookingHairdresser>(context)
        ..values = bookingHairdresserRelation;

      await relationQuery.insert();
    }

    bookingQuery
      ..values = _booking
      ..values.lastEdited = DateTime.now();

    return Response.ok(await bookingQuery.updateOne());
  }

  @Operation.delete('id')
  Future<Response> deleteBookingByID(@Bind.path('id') int id) async {
    final query = Query<ManagedBooking>(context)
      ..where((booking) => booking.id).equalTo(id);

    final booking = await query.fetchOne();

    if (booking == null) {
      return Response.notFound();
    }
    return Response.ok(await query.delete());
  }
}

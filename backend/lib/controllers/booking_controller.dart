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
    final query = Query<ManagedBooking>(context);
    return Response.ok(await query.fetch());
  }

  @Operation.post()
  Future<Response> addBooking(
      @Bind.body(ignore: ["id"]) ManagedBooking booking) async {
    final query = Query<ManagedBooking>(context)..values = booking;
    return Response.ok(await query.insert());
  }

  @Operation.put('id')
  Future<Response> updateBooking(@Bind.path('id') int id,
      @Bind.body(ignore: ["id"]) ManagedBooking booking) async {
    final query = Query<ManagedBooking>(context)
      ..where((booking) => booking.id).equalTo(id)
      ..values = booking;
    return Response.ok(await query.updateOne());
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

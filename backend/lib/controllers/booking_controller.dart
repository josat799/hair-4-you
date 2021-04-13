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
  Future<Response> getUsers() async {
    final query = Query<ManagedBooking>(context);
    return Response.ok(await query.fetch());
  }
}

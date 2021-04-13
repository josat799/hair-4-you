import 'backend.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class Hair4YouChannel extends ApplicationChannel {
  User user = User(
    id: 1,
    createdAt: DateTime.now(),
    birthDate: DateTime(1997, 5, 30),
    email: 'josef.atoui@live.se',
    lastLoggedIn: DateTime.now(),
    name: 'Josef Atoui',
  );

  Booking booking = Booking(
    id: 1,
    startTime: DateTime(2021, 5, 20, 12, 30),
    title: 'Vanlig klippning',
    createdAt: DateTime.now(),
    duration: Duration(hours: 1),
    lastEdited: DateTime.now(),
  );

  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();
    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router.route("/example").linkFunction((request) async {
      booking.customers?.add(user);
      user.bookings?.add(booking);
      return Response.ok(
        {
          'bookings': [booking],
          'users': [user]
        },
      )..contentType = ContentType.json;
    });

    return router;
  }
}

import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:models/booking_models/booking.dart';

class Migration2 extends Migration {
  @override
  Future upgrade() async {}

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    await database.store.execute(
        "INSERT INTO bookings (title, starttime, createdat, duration, amountofcustomers, lastedited) VALUES (@title, @starttime, @createdat, @duration, @amountofcustomers, @lastedited)",
        substitutionValues: {
          "title": "Simple Cutting",
          "starttime": DateTime(2021, 05, 08, 15, 00),
          "duration": Duration(minutes: 30).inMinutes,
          "createdat": DateTime.now(),
          "amountofcustomers": 1,
          "lastedited": DateTime.now(),
        });

    await database.store.execute(
        "INSERT INTO bookings (title, starttime, createdat, duration, amountofcustomers, lastedited) VALUES (@title, @starttime, @createdat, @duration, @amountofcustomers, @lastedited)",
        substitutionValues: {
          "title": "Extended Cutting",
          "starttime": DateTime(2021, 05, 08, 16, 00),
          "duration": const Duration(hours: 1).inMinutes,
          "createdat": DateTime.now(),
          "amountofcustomers": 2,
          "lastedited": DateTime.now(),
        });
  }
}

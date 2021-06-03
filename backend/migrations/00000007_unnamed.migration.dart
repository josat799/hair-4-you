import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration7 extends Migration {
  @override
  Future upgrade() async {
    database.addColumn(
        "BookingsCustomers",
        SchemaColumn.relationship("booking", ManagedPropertyType.bigInteger,
            relatedTableName: "Bookings",
            relatedColumnName: "id",
            rule: DeleteRule.nullify,
            isNullable: true,
            isUnique: false));
    database.addColumn(
        "BookingsCustomers",
        SchemaColumn.relationship("customer", ManagedPropertyType.bigInteger,
            relatedTableName: "Users",
            relatedColumnName: "id",
            rule: DeleteRule.nullify,
            isNullable: true,
            isUnique: false));
    database.deleteColumn("BookingsCustomers", "bookings");
    database.deleteColumn("BookingsCustomers", "users");
    database.addColumn(
        "BookingsHairdressers",
        SchemaColumn.relationship("hairDresser", ManagedPropertyType.bigInteger,
            relatedTableName: "Users",
            relatedColumnName: "id",
            rule: DeleteRule.nullify,
            isNullable: true,
            isUnique: false));
    database.addColumn(
        "BookingsHairdressers",
        SchemaColumn.relationship("booking", ManagedPropertyType.bigInteger,
            relatedTableName: "Bookings",
            relatedColumnName: "id",
            rule: DeleteRule.nullify,
            isNullable: true,
            isUnique: false));
    database.deleteColumn("BookingsHairdressers", "hairDressers");
    database.deleteColumn("BookingsHairdressers", "bookings");
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {}
}

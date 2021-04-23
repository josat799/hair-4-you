import 'package:backend/backend.dart';

class UserController extends ResourceController {
  UserController(this.context);

  final ManagedContext context;

  @Operation.get('id')
  Future<Response> getUserByID(@Bind.path('id') int id) async {
    final query = Query<ManagedUser>(context)
      ..where((user) => user.id).equalTo(id);

    final user = await query.fetchOne();

    if (user == null) {
      return Response.notFound();
    }
    return Response.ok(user);
  }

  @Operation.get()
  Future<Response> getUsers({@Bind.query("email") String email}) async {
    final query = Query<ManagedUser>(context);
    if (email != null) {
      query..where((u) => u.email).equalTo(email);
    }
    final users = await query.fetch();

    if (users.isEmpty) {
      return Response.notFound();
    }

    return Response.ok(users);
  }

  @Operation.post()
  Future<Response> addUser(
      @Bind.body(ignore: ["id"]) ManagedUser booking) async {
    final query = Query<ManagedUser>(context)..values = booking;
    return Response.ok(await query.insert());
  }

  @Operation.put('id')
  Future<Response> updateUser(@Bind.path('id') int id,
      @Bind.body(ignore: ["id"]) ManagedUser booking) async {
    final query = Query<ManagedUser>(context)
      ..where((booking) => booking.id).equalTo(id)
      ..values = booking;
    return Response.ok(await query.updateOne());
  }

  @Operation.delete('id')
  Future<Response> deleteUserByID(@Bind.path('id') int id) async {
    final query = Query<ManagedUser>(context)
      ..where((booking) => booking.id).equalTo(id);

    final booking = await query.fetchOne();

    if (booking == null) {
      return Response.notFound();
    }
    return Response.ok(await query.delete());
  }
}

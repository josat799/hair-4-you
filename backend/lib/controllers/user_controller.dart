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
  Future<Response> getUsers() async {
    final query = Query<ManagedUser>(context);

    return Response.ok(await query.fetch());
  }
}

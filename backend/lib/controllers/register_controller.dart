import '../backend.dart';

class RegisterController extends ResourceController {
  RegisterController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.post()
  Future<Response> createUser(@Bind.body() ManagedUser user) async {
    // Check for required parameters before we spend time hashing
    if (user.password == null || user.email == null) {
      return Response.badRequest(
          body: {"error": "username and password required."});
    }

    user.createdAt = DateTime.now();
    user.lastLoggedIn = DateTime.now();
    user.username = user.email;
    user.role = userType.customer;

    user
      ..salt = AuthUtility.generateRandomSalt()
      ..hashedPassword = authServer.hashPassword(user.password, user.salt);

    return Response.ok(await Query(context, values: user).insert());
  }
}

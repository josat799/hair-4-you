import 'package:backend/backend.dart';

class TokenController extends ResourceController {
  TokenController(this.context, this.authServer);

  ManagedContext context;
  AuthServer authServer;

  @Operation.get('token')
  Future<Response> verifyToken(@Bind.path('token') String token) async {
    if (token == null) {
      return Response.badRequest(body: {"error": "Must include a token"});
    }

    try {
      final Authorization auth = await authServer.verify(token);
      return Response.ok({});
    } catch (e) {
      return Response.unauthorized();
    }
  }
}

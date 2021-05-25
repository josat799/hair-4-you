import 'package:http/http.dart' as http;

import '../backend.dart';

class GoogleController extends ResourceController {
  GoogleController(this.context) {
    acceptedContentTypes = [
      ContentType("application", "x-www-form-urlencoded")
    ];
  }

  final ManagedContext context;

  @Operation.post()
  Future<Response> login(
    @Bind.query('google_token') String token,
  ) async {
    try {
      final http.Response response = await http
          .get('https://oauth2.googleapis.com/tokeninfo?id_token=$token');

      final data = jsonDecode(response.body);
      final query = Query<ManagedUser>(context);

      print(data['email']);
      if (data['email'] != null) {
        query.where((user) => user.email == data['email']);
        print('Still Works');
        final ManagedUser user = (await query.fetch()).first;

        if (user != null) {
          //await query.insert()
        }
      }

      return Response(response.statusCode, null, null);
    } catch (error) {}
  }
}

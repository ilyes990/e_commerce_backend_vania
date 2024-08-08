import 'package:vania/vania.dart';

class AuthenticateMiddleware extends Authenticate {
  @override
  handle(Request req) async {
    print('authenticated');
    final token = req.header("authorization") ?? "";
    await Auth().check(token);

    return next?.handle(req);
  }
}

import 'package:vania/vania.dart';
import 'package:vania_ecommerce_api/route/api_route.dart';
import 'package:vania_ecommerce_api/route/web.dart';
import 'package:vania_ecommerce_api/route/web_socket.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    WebRoute().register();
    ApiRoute().register();
    WebSocketRoute().register();
  }
}

/*

create test route.dart onside route
39:00

class TestRoute implements Route {
@overidde
void register (){
    Router.basePrefix('tapi');

    Router.get("/home", homeController.test);
}

}


 */

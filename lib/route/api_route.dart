import 'package:vania/vania.dart';
import 'package:vania_ecommerce_api/app/http/controllers/auth_controller.dart';
import 'package:vania_ecommerce_api/app/http/controllers/home_controller.dart';
import 'package:vania_ecommerce_api/app/http/controllers/profile_controller.dart';
import 'package:vania_ecommerce_api/app/http/middleware/authenticate.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');
    Router.post('/register', authController.register);
    Router.post('/login', authController.login);
    Router.put("/updatepassword", authController.updatePassword);

    Router.group(() {
      // Products
      Router.post('/getproducts', homeController.productList);
      Router.post('/detail', homeController.detail);
      Router.post('/search', homeController.search);

      // Wish List
      Router.post("/addwishlist", profileController.addWishList);
      Router.post("/my_wish_list", profileController.mywishList);
    }, middleware: [AuthenticateMiddleware()]);
  }
}

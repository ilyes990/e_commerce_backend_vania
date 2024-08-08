import 'package:vania/vania.dart';
import 'package:vania_ecommerce_api/app/models/wishlist.dart';

class ProfileController extends Controller {
  Future<Response> addWishList(Request request) async {
    try {
      var idproduct = request.input('idproducts').toString();
      // if (idproduct == null) {
      //   return Response.json(
      //       {"code": "401", "msg": "Not authorised", "data": ""}, 401);
      // }

      final userId = Auth().id();
      print(userId);
      final wishlist = await Wishlist()
          .query()
          .where("user_id", "=", userId)
          .where("product_id", "=", idproduct)
          .first();

      // cancel the item from the wishlist ..
      //
      if (wishlist != null) {
        await Wishlist()
            .query()
            .where("product_id", "=", idproduct)
            .where("user_id", "=", userId)
            .delete();
        return Response.json({
          "code": 200,
          "data": "",
          "msg": "Wish list canceled for this product"
        });
      } else {
        await Wishlist().query().insert({
          "user_id": userId,
          "product_id": idproduct,
          "created_at": DateTime.now(),
          "updated_at": DateTime.now()
        });
        return Response.json({
          "code": 200,
          "data": "",
          "msg": "wishlist added for this product"
        });
      }
    } catch (e) {
      return Response.json(
          {"code": "500", "msg": "error handling wishlist", "data": ""}, 500);
    }
  }

  Future<Response> mywishList(Request request) async {
    try {
      final userId = Auth().id();

      final wishlist = await Wishlist()
          .query()
          .join('products', 'products.idproducts', '=', 'wishlists.product_id')
          .select(['products.*'])
          .where('wishlists.user_id', '=', userId)
          .get();

      return Response.json(
          {"code": 200, "data": wishlist, "msg": "returned wishlist"});
      // cancel the item from the wishlist ..
      //
    } catch (e) {
      return Response.json(
          {"code": "500", "msg": "error handling wishlist", "data": ""}, 500);
    }
  }
}

final ProfileController profileController = ProfileController();

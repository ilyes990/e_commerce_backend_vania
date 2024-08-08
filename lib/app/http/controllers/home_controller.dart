import 'package:vania/vania.dart';
import 'package:vania_ecommerce_api/app/models/products.dart';

class HomeController extends Controller {
  Future<Response> productList(Request request) async {
    try {
      final categoryId = request.input("idproducts").toString();
      final specifiProduct =
          await Products().query().where("category_id", "=", categoryId).get();

      if (specifiProduct.isNotEmpty) {
        return Response.json({
          "code": "200",
          "msg": "success getting all products",
          "data": specifiProduct
        }, 200);
      } else {
        return Response.json({
          "code": "204",
          "msg": "there is no products in the list",
          "data": specifiProduct
        }, 204);
      }
    } catch (_) {
      return Response.json(
          {"code": "500", "msg": "error getting data", "data": ""}, 500);
    }
  }

  Future<Response> detail(Request request) async {
    try {
      final id = request.input("idproducts").toString();

      if (id == null) {
        return Response.json(
            {"code": "401", "msg": "Not authorised", "data": ""}, 401);
      }
      final productDetail =
          await Products().query().where("idproducts", "=", id).get();

      if (productDetail == null) {
        return Response.json(
            {"code": "204", "msg": "product not found", "data": ""}, 204);
      } else {
        return Response.json({
          "code": "200",
          "msg": "product detail found",
          "data": productDetail
        }, 200);
      }
    } catch (_) {
      return Response.json(
          {"code": "500", "msg": "error getting data", "data": ""}, 500);
    }
  }

  Future<Response> search(Request request) async {
    try {
      final title = request.input("title");

      if (title == null) {
        return Response.json(
            {"code": "401", "msg": "Not authorised", "data": ""}, 401);
      }

      if (title == "init") {
        final searchDefault = await Products().query().limit(5).get();
        return Response.json({
          "code": "200",
          "msg": "Default search result",
          "data": searchDefault
        }, 200);
      }

      final searchResult =
          await Products().query().where("title", "like", "%$title").get();
      return Response.json({
        "code": "200",
        "msg": "Custom Search result found",
        "data": searchResult
      }, 200);
    } catch (_) {
      return Response.json(
          {"code": "500", "msg": "error getting data", "data": ""}, 500);
    }
  }
}

final HomeController homeController = HomeController();

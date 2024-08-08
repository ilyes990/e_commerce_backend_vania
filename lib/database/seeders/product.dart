// import 'package:faker/faker.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:vania/vania.dart';
import 'package:vania_ecommerce_api/app/models/user.dart';

class Product extends Seeder {
  @override
  Future<void> run() async {
    try {
      // TODO: implement run
      final faker = Faker.instance;
      for (var i = 0; i < 10; i++) {
        await User().query().insert({
          "name": faker.name.fullName(),
          "email": faker.internet.email(),
          "password": Hash().make("user"),
          "avatar": faker.image.image(),
          "description": "No user content found",
          "created_at": DateTime.now(),
          "edited_at": DateTime.now()
        });
      }
      print("Product call");
    } catch (e) {
      print(e.toString());
    }
  }
}

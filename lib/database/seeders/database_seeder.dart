import 'dart:io';
import 'package:vania/vania.dart';
import 'product.dart';

void main() async {
  Env().load();
  await DatabaseClient().setup();
  await DatabaseSeeder().registry();
  await DatabaseClient().database?.close();
  exit(0);
}

class DatabaseSeeder {
  registry() async{
		
		 await Product().run();
	}
}

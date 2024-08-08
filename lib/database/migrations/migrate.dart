import 'dart:io';

import 'package:vania/vania.dart';
import 'package:vania_ecommerce_api/database/migrations/create_tokens.dart';

import 'users.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
    await Users().up();
    await CreateTokens().up();
  }

  dropTables() async {
    await Users().down();
    await CreateTokens().down();
  }
}

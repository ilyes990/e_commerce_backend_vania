import 'package:vania/vania.dart';

class Users extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('users', () {
      id();
      char('name', length: 100);
      char('avatar', length: 200);
      char('password', length: 200);
      char('email', length: 200);
      char('phone', length: 150);
      longText('description');
      char('birthday', length: 150);
      mediumInt('gender', length: 150);
      dateTime('created_at');
      dateTime('edited_at');
      dateTime('deleted_at');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('users');
  }
}

import 'package:drift/web.dart';
import 'shared_database.dart';

SharedDatabase constructDb() {
  return SharedDatabase(connectOnWeb());
}

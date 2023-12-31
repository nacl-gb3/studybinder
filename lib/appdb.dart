import 'package:drift/drift.dart';
import 'tables.dart';
import 'database_connection/connection.dart' as connector;
import 'login.dart';

part 'appdb.g.dart';

@DriftDatabase(tables: [Users, Questions])
class AppDatabase extends _$AppDatabase {

	AppDatabase(): super(connector.connect(Login.activeCourse!));

	@override
	int get schemaVersion => 1;
}

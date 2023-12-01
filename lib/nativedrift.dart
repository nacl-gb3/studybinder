import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'shared_database.dart';

SharedDatabase constructDb(String courseName) {
  final db = LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, '$courseName.db'));
    return NativeDatabase(file);
  });
  return SharedDatabase(db);
}

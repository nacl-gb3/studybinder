/*
MIT License

Copyright (c) 2019 Simon Binder

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
// For bottom function; DO NOT DELETE
//import 'package:drift_dev/api/migrations.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

Future<File> getDatabaseFile(String courseName) async {
  // We use `path_provider` to find a suitable path to store our data in.
  final appDir = await getApplicationDocumentsDirectory();
  debugPrint(appDir.toString());
  final dbPath = p.join(appDir.path, 'sb_questions/databases/$courseName.db');
  debugPrint(dbPath.toString());
  return File(dbPath);
}

/// Obtains a database connection for running drift in a Dart VM.
DatabaseConnection connect(String courseName) {
  return DatabaseConnection.delayed(Future(() async {
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();

      final cachebase = (await getTemporaryDirectory()).path;

      // We can't access /tmp on Android, which sqlite3 would try by default.
      // Explicitly tell it about the correct temporary directory.
      sqlite3.tempDirectory = cachebase;
    }

    return NativeDatabase.createBackgroundConnection(
      await getDatabaseFile(courseName),
    );
  }));
}

/*
Future<void> validateDatabaseSchema(GeneratedDatabase database) async {
  // This method validates that the actual schema of the opened database matches
  // the tables, views, triggers and indices for which drift_dev has generated
  // code.
  // Validating the database's schema after opening it is generally a good idea,
  // since it allows us to get an early warning if we change a table definition
  // without writing a schema migration for it.
  //
  // For details, see: https://drift.simonbinder.eu/docs/advanced-features/migrations/#verifying-a-database-schema-at-runtime
  if (kDebugMode) {
    await VerifySelf(database).validateDatabaseSchema();
  }
}
*/

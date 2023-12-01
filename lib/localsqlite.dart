import 'dart:io';
import 'package:sqlite3/common.dart';
import 'package:sqlite3/sqlite3.dart';

CommonDatabase? getDatabase(String dbName) {
	String courseFilePath = "databases/$dbName.db";
	File f = File(courseFilePath);

	if (!f.existsSync()) {
		return null;
	}

	CommonDatabase db = sqlite3.open(courseFilePath);

	return db;
}


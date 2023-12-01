import 'package:sqlite3/common.dart';
import 'package:sqlite3/wasm.dart';

Future<WasmSqlite3> loadWasmSqlite() async {
  final fs = await IndexedDbFileSystem.open(dbName: '1337');

  return await WasmSqlite3.loadFromUrl(
      Uri.parse('sqlite.wasm'), 
  );
}

Future<CommonDatabase?> getWebDatabase(String dbName) async {
	String courseFilePath = "databases/$dbName.db";

	WasmSqlite3 wasmSqlite = await loadWasmSqlite();

	CommonDatabase db = wasmSqlite.open(courseFilePath);

	return db;
}


import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class SqliteDBProvider {
  String databaseName = 'medfind.db';

  // late Database sqliteDB;

  // SqliteDBProvider() {
  //   sqliteDB = _initializeDB() as Database;
  // }

  Future<Database> _initializeDB() async {
    final defaultDatabasePath = await getDatabasesPath();
    final fullDatabasePath = join(defaultDatabasePath, databaseName);

    return openDatabase(
      fullDatabasePath,
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE pills(id INTEGER PRIMARY KEY,  medicine_name TEXT NOT NULL, strength INTEGER, amount INTEGER);",
        );
        await database.execute(
          "CREATE TABLE medpacks(id INTEGER PRIMARY KEY, tag TEXT NULL, medpack_pills TEXT NOT NULL);",
        );

        // Other tables
      },
      version: 1,
    );
  }

  Future<Map<String, Object>?> getById(String table, int id) async {
    final db = _initializeDB() as Database;
    List<Map<String, Object>?> queryResult =
        await db.query(table, where: 'id=$id') as List<Map<String, Object>?>;
    db.close();
    return queryResult.first;
  }

  Future<int> insert(String table, Map<String, Object> data) async {
    final db = _initializeDB() as Database;
    int affected = await db.insert('medpacks', data);
    db.close();
    return affected;
  }

  Future<List<Map<String, Object?>>> get(String table) async {
    final db = _initializeDB() as Database;
    final List<Map<String, Object?>> queryResult = await db.query('medpacks');
    db.close();
    return queryResult;
  }

  Future<void> delete(String table, int id) async {
    final db = _initializeDB() as Database;
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
    db.close();
  }

  Future<List<Map<String, Object?>>> update<M>(
      String table, int id, String field, M newValue) async {
    final db = _initializeDB() as Database;

    final affectedCount =
        db.rawUpdate('UPDATE $table SET $field = $newValue WHERE id = $id');

    final List<Map<String, Object?>> queryResult =
        await db.query(table, where: 'id = $id');
    db.close();

    return queryResult;
  }

  Future<List<Map<String, Object?>>> updateFields<M>(
      String table, int id, List<String> field, List<M> newValue) async {
    final db = _initializeDB() as Database;
    for (int i = 0; i < field.length; i++) {
      var column = field[i];
      var value = newValue[i];
      db.rawUpdate('UPDATE $table SET $column = $value WHERE id = $id');
    }
    final List<Map<String, Object?>> queryResult =
        await db.query(table, where: 'id = $id');
    db.close();

    return queryResult;
  }
}

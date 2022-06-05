import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class SqliteDBProvider {
  String databaseName = 'medfind.db';

  // late Database sqliteDB;

  // SqliteDBProvider() {
  //   sqliteDB =  _initializeDB() as Database;
  // }

  Future<Database> _initializeDB() async {
    final defaultDatabasePath = await getDatabasesPath();
    final fullDatabasePath = join(defaultDatabasePath, databaseName);
    try {
      return await openDatabase(
        fullDatabasePath,
        onCreate: (database, version) async {
          await database.execute(
            "CREATE TABLE pills(id INTEGER PRIMARY KEY,  medicine_name TEXT NOT NULL, strength INTEGER, amount INTEGER);",
          );
          await database.execute(
            "CREATE TABLE medpacks(id INTEGER PRIMARY KEY, tag TEXT NULL, medpack_pills TEXT NOT NULL);",
          );

          await database.execute(
            "CREATE TABLE reservations(id INTEGER PRIMARY KEY,pharmacy TEXT NOT NULL , medPacks TEXT NOT NULL);",
          );
          await database.execute(
            "CREATE TABLE users(id INTEGER PRIMARY KEY, firstName TEXT NOT NULL, lastName TEXT NOT NULL, email TEXT NOT NULL, role TEXT NOT NULL)",
          );
          await database.execute(
            "CREATE TABLE pharmacies(id INTEGER PRIMARY KEY,name TEXT NOT NULL, owner TEXT NOT NULL, address TEXT NOT NULL, location TEXT NULL)",
          );
          // Other tables
        },
        version: 1,
      );
    } catch (exp) {
      print("initialiazation error" + exp.toString());
      rethrow;
    }
  }

  Future<bool> clearTable(String table) async {
    try {
      final db = await _initializeDB();
      int affected = await db.delete(table) as int;
      db.close();
      return affected > 0;
    } catch (exp) {
      rethrow;
    }
  }

  Future<Map<String, Object>?> getById(String table, int id) async {
    try {
      final db = await _initializeDB();
      List<Map<String, Object>?> queryResult =
          await db.query(table, where: 'id=$id') as List<Map<String, Object>?>;
      db.close();
      return queryResult.first;
    } catch (exp) {
      rethrow;
    }
  }

  Future<int> insert(String table, Map<String, Object> data) async {
    try {
      final db = await _initializeDB();
      int affected = await db.insert('$table', data);
      db.close();
      return affected;
    } catch (exp) {
      rethrow;
    }
  }

  Future<List<Map<String, Object?>>> get(String table) async {
    try {
      final db = await _initializeDB();
      final List<Map<String, Object?>> queryResult = await db.query('$table');
      db.close();
      return queryResult;
    } catch (exp) {
      rethrow;
    }
  }

  Future<bool> delete(String table, int id) async {
    try {
      final db = await _initializeDB();
      int affected = await db.delete(table, where: 'id = ?', whereArgs: [id]);
      db.close();
      return 0 < affected;
    } catch (exp) {
      rethrow;
    }
  }

  Future<List<Map<String, Object?>>> update<M>(
      String table, int id, String field, M newValue) async {
    try {
      final db = await _initializeDB();

      final affectedCount =
          db.rawUpdate('UPDATE $table SET $field = $newValue WHERE id = $id');

      final List<Map<String, Object?>> queryResult =
          await db.query(table, where: 'id = $id');
      db.close();

      return queryResult;
    } catch (exp) {
      rethrow;
    }
  }

  Future<List<Map<String, Object?>>> updateFields<M>(
      String table, int id, List<String> field, List<M> newValue) async {
    try {
      final db = await _initializeDB();
      for (int i = 0; i < field.length; i++) {
        var column = field[i];
        var value = newValue[i];
        db.rawUpdate('UPDATE $table SET $column = $value WHERE id = $id');
      }
      final List<Map<String, Object?>> queryResult =
          await db.query(table, where: 'id = $id');
      db.close();

      return queryResult;
    } catch (exp) {
      rethrow;
    }
  }
}

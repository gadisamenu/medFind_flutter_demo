import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper();
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    return await openDatabase(
      await getDatabasesPath(),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE pills(id INTEGER PRIMARY KEY,  medicine_name TEXT  , strength INTEGER, amount INTEGER);",
    );
    await db.execute(
      "CREATE TABLE medpacks(id INTEGER PRIMARY KEY, tag TEXT , medpack_pills TEXT  );",
    );

    await db.execute(
      "CREATE TABLE reservations(id INTEGER PRIMARY KEY,pharmacy TEXT   , medPacks TEXT  );",
    );
    await db.execute(
      "CREATE TABLE users(id INTEGER PRIMARY KEY, firstName TEXT  , lastName TEXT  , email TEXT  , role TEXT  )",
    );
    await db.execute(
      "CREATE TABLE pharmacies(id INTEGER PRIMARY KEY,name TEXT , owner TEXT , address TEXT , location TEXT )",
    );
  }

  Future<bool> clearTable(String table) async {
    try {
      Database db = await instance.database;
      int affected = await db.delete(table);
      return affected > 0;
    } catch (exp) {
      rethrow;
    }
  }

  Future<Map<String, Object>?> getById(String table, int id) async {
    try {
      Database db = await instance.database;
      final queryResult = await db.query(table, where: 'id=$id');
      return queryResult.first as Map<String, Object>;
    } catch (exp) {
      rethrow;
    }
  }

  Future<int> insert(String table, Map<String, Object?> data) async {
    try {
      Database db = await instance.database;
      int affected = await db.insert('$table', data);
      return affected;
    } catch (exp) {
      rethrow;
    }
  }

  Future<List<Map<String, Object?>>> get(String table) async {
    try {
      Database db = await instance.database;
      final queryResult = await db.query('$table');
      return queryResult;
    } catch (exp) {
      rethrow;
    }
  }

  Future<bool> delete(String table, int id) async {
    try {
      Database db = await instance.database;
      int affected = await db.delete(table, where: 'id = ?', whereArgs: [id]);
      return 0 < affected;
    } catch (exp) {
      rethrow;
    }
  }

  Future<List<Map<String, Object?>>> update<M>(
      String table, int id, String field, M newValue) async {
    try {
      Database db = await instance.database;

      final affectedCount =
          db.rawUpdate("UPDATE $table SET $field = '$newValue' WHERE id = $id");

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
      Database db = await instance.database;
      for (int i = 0; i < field.length; i++) {
        var column = field[i];
        var value = newValue[i];
        db.rawUpdate("UPDATE $table SET $column = '$value' WHERE id = $id");
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

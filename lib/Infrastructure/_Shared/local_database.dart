import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class SqliteDBProvider {
  String databaseName = 'medfind.db';

  Future<Database> initializeDB() async {
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
        await database.execute(
          "CREATE TABLE reservations(id INTEGER PRIMARY KEY,pharmacy TEXT NOT NULL , medPacks TEXT NOT NULL);",
        );
        // Other tables
      },
      version: 1,
    );
  }
}

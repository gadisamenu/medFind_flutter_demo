import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/value_objects.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/DataSource/_watchlist_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/local_database.dart';
import 'package:sqflite/sqflite.dart';

class LocalWatchListDataProvider extends SqliteDBProvider
    implements WatchListDataProvider {
  @override
  Future<MedPack?> addNewMedpack(String description, {int? medpackId}) async {
    MedPack newMedpack = MedPack(description, {});
    newMedpack.setMedpackId(medpackId!);

    final db = initializeDB() as Database;
    final id = await db.insert('medpacks', newMedpack.toJson());
    return newMedpack;
  }

  @override
  Future<Pill?> addNewPill(int medpackId, String name, int strength, int amount,
      {int? pillId}) async {
    MedicineName medName = MedicineName(name);

//
//
//
//
    Pill newPill = Pill(pillId!, medName, strength, amount);

    final db = await initializeDB();
    final id = await db.insert('medpacks', newPill.toJson());
    return newPill;
  }

  @override
  Future<List<MedPack>?> getMedPacks() async {
    final db = await initializeDB();

    final List<Map<String, Object?>> queryResult = await db.query('medpacks');
    return queryResult.map((record) => MedPack.fromJson(record)).toList();
  }

  @override
  Future<void> removeMedpack(int medpackId) async {
    final db = await initializeDB();
    final removedCount =
        await db.delete('medpacks', where: 'id = ?', whereArgs: [medpackId]);
  }

  @override
  Future<void> removePill(int pillId) async {
    final db = await initializeDB();
    final removedCount =
        await db.delete('pills', where: 'id = ?', whereArgs: [pillId]);
  }

  @override
  Future<MedPack?> updateMedpack(int medpackId, String tag) async {
    final db = await initializeDB();
    final affectedCount = db.rawUpdate(
        'UPDATE medpacks SET description = ? WHERE id = ?', [tag, medpackId]);

    final List<Map<String, Object?>> queryResult =
        await db.query('medpacks', where: 'id = ?', whereArgs: [medpackId]);

    return queryResult.map((e) => MedPack.fromJson(e)).toList().first;
  }

  @override
  Future<Pill?> updatePill(int pillId, int strength, int amount) async {
    final db = await initializeDB();
    final affectedCount = db.rawUpdate(
        'UPDATE pills SET strength = ?, amount = ? WHERE id = ?',
        [strength, amount, pillId]);

    final List<Map<String, Object?>> queryResult =
        await db.query('pills', where: 'id = ?', whereArgs: [pillId]);

    return queryResult.map((e) => Pill.fromJson(e)).toList().first;
  }
}

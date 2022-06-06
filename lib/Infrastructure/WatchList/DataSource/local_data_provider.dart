import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/value_objects.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/DataSource/_watchlist_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/_Shared/local_database.dart';

class LocalWatchListDataProvider extends SqliteDBProvider
    implements WatchListDataProvider {
  @override
  Future<MedPack?> addNewMedpack(String description, {int? medpackId}) async {
    MedPack newMedpack = MedPack({});
    newMedpack.setDescription(description);

    newMedpack.setMedpackId(medpackId!);

    await insert('medpacks', newMedpack.toJson());
    return newMedpack;
  }

  @override
  Future<Pill?> addNewPill(
      int medpackId, MedicineName name, int strength, int amount,
      {int? pillId}) async {
    Pill newPill = Pill(pillId!, name, strength, amount);

    insert('pills', newPill.toJson());
    return newPill;
  }

  @override
  Future<List<MedPack>?> getMedPacks() async {
    final List<Map<String, Object?>> queryResult = await get('medpacks');
    return queryResult.map((record) => MedPack.fromJson(record)).toList();
  }

  @override
  Future<void> removeMedpack(int medpackId) async {
    await delete('medpacks', medpackId);
  }

  @override
  Future<void> removePill(int medpackId, int pillId) async {
    Map<String, Object?> data = await getById('medpacks', medpackId);
    MedPack updatedMedpack = MedPack.fromJson(data);

    updatedMedpack.removePill(pillId);
    await update('medpacks', medpackId, 'medpack_pills', updatedMedpack.toJson);
    await delete('pills', pillId);
  }

  @override
  Future<MedPack?> updateMedpack(int medpackId, String tag) async {
    final List<Map<String, Object?>> queryResult =
        await update<String>('medpacks', medpackId, 'description', tag);
    return queryResult.map((e) => MedPack.fromJson(e)).toList().first;
  }

  @override
  Future<Pill?> updatePill(
      int medpackId, int pillId, int strength, int amount) async {
    final List<Map<String, Object?>> queryResult = await updateFields(
        'pills', pillId, ['strength', 'amount'], [strength, amount]);

    Map<String, Object?> data = await getById('medpacks', medpackId);
    MedPack updatedMedpack = MedPack.fromJson(data);
    updatedMedpack.updatePill(pillId, strength, amount);

    await update(
        'medpacks', medpackId, 'medpack_pills', updatedMedpack.toJson());

    return queryResult.map((e) => Pill.fromJson(e)).toList().first;
  }
}

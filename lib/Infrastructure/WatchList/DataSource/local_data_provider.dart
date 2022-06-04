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

    insert('medpacks', newMedpack.toJson());
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
    final List<Map<String, Object?>> queryResult =
        get('medpacks') as List<Map<String, Object?>>;
    return queryResult.map((record) => MedPack.fromJson(record)).toList();
  }

  @override
  Future<void> removeMedpack(int medpackId) async {
    delete('medpacks', medpackId);
  }

  @override
  Future<void> removePill(int medpackId, int pillId) async {
    Map<String, Object?> data =
        getById('medpacks', medpackId) as Map<String, Object?>;
    MedPack updatedMedpack = MedPack.fromJson(data);

    updatedMedpack.removePill(pillId);
    update('medpacks', medpackId, 'medpack_pills', updatedMedpack.toJson);
    delete('pills', pillId);
  }

  @override
  Future<MedPack?> updateMedpack(int medpackId, String tag) async {
    final List<Map<String, Object?>> queryResult =
        update<String>('medpacks', medpackId, 'description', tag)
            as List<Map<String, Object?>>;
    return queryResult.map((e) => MedPack.fromJson(e)).toList().first;
  }

  @override
  Future<Pill?> updatePill(
      int medpackId, int pillId, int strength, int amount) async {
    final List<Map<String, Object?>> queryResult = updateFields(
            'pills', pillId, ['strength', 'amount'], [strength, amount])
        as List<Map<String, Object?>>;

    Map<String, Object?> data =
        getById('medpacks', medpackId) as Map<String, Object?>;
    MedPack updatedMedpack = MedPack.fromJson(data);
    updatedMedpack.updatePill(pillId, strength, amount);

    update('medpacks', medpackId, 'medpack_pills', updatedMedpack.toJson());

    return queryResult.map((e) => Pill.fromJson(e)).toList().first;
  }
}

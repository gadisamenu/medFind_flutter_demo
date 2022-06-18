import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Domain/WatchList/value_objects.dart';
import 'package:medfind_flutter/Domain/_Shared/common.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/DataSource/_watchlist_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/DataSource/local_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/DataSource/remote_data_provider.dart';

class WatchListRepository {
  final HttpRemoteWatchListDataProvider dataProvider =
      HttpRemoteWatchListDataProvider();

  final WatchListDataProvider localDataProvider = LocalWatchListDataProvider();

  Future<List<MedPack>?> getMedPacks() async {
    List<MedPack>? medpacks = await localDataProvider.getMedPacks();

    if (medpacks == null || medpacks.isEmpty) {
      medpacks = await dataProvider.getMedPacks();

      for (MedPack mp in medpacks as List<MedPack>) {
        localDataProvider.addNewMedpack(mp.description,
            medpackId: mp.medpackId);
      }
    }
    return medpacks;
  }

  Future<MedPack?> addMedPack(String description) async {
    MedPack? newMedpack = MedPack({});
    newMedpack.setDescription(description);

    newMedpack = await dataProvider.addNewMedpack(description);

    await localDataProvider.addNewMedpack(description,
        medpackId: newMedpack!.medpackId);

    return newMedpack;
  }

  Future<void> removeMedPack(int medpackId) async {
    await dataProvider.removeMedpack(medpackId);

    await localDataProvider.removeMedpack(medpackId);
  }

  Future<MedPack?> updateMedpack(int medpackId, String tag) async {
    MedPack? updatedMedpack = MedPack({});
    updatedMedpack.setDescription(tag);

    updatedMedpack = await dataProvider.updateMedpack(medpackId, tag);

    await localDataProvider.updateMedpack(medpackId, tag);
    return updatedMedpack;
  }

  Future<Pill?> addPill(
      int medpackId, String medicineName, int strength, int amount) async {
    MedicineName medName = MedicineName(medicineName);
    Pill? newPill = Pill(0, medName, strength, amount);

    if (!newPill.validate()) {
      throw InvalidValueException("Invalid inputs to pill");
    }

    newPill =
        await dataProvider.addNewPill(medpackId, medName, strength, amount);

    await localDataProvider.addNewPill(medpackId, medName, strength, amount);
    return newPill;
  }

  Future<void> removePill(int medpackId, int pillId) async {
    await dataProvider.removePill(medpackId, pillId);

    await localDataProvider.removePill(medpackId, pillId);
  }

  Future<Pill?> updatePill(
      int medpackId, int pillId, int strength, int amount) async {
    Pill? updatedPill =
        Pill(0, const MedicineName('validation'), strength, amount);

    if (!updatedPill.validate()) {
      throw InvalidValueException("Invalid inputs to pill");
    }

    updatedPill =
        await dataProvider.updatePill(medpackId, pillId, strength, amount);

    await localDataProvider.updatePill(medpackId, pillId, strength, amount);

    return updatedPill;
  }
}

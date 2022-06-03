import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/DataSource/_watchlist_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/DataSource/local_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/DataSource/remote_data_provider.dart';

class WatchListRepository {
  final HttpRemoteWatchListDataProvider dataProvider =
      HttpRemoteWatchListDataProvider();

  final WatchListDataProvider localDataProvider = LocalWatchListDataProvider();

  Future<List<Pharmacy>?> searchMedicines(int medpackId) async {
    List<Pharmacy>? pharmacies = await dataProvider.searchMedicines(medpackId);
    return pharmacies;
  }

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
    MedPack? newMedpack;
    try {
      newMedpack = await dataProvider.addNewMedpack(description);
    } catch (e) {
      print(e.toString());
      return null;
    }

    await localDataProvider.addNewMedpack(description,
        medpackId: newMedpack!.medpackId);

    return newMedpack;
  }

  Future<void> removeMedPack(int medpackId) async {
    try {
      await dataProvider.removeMedpack(medpackId);
    } catch (error) {
      print(error.toString());
      return;
    }
    await localDataProvider.removeMedpack(medpackId);
  }

  Future<MedPack?> updateMedpack(int medpackId, String tag) async {
    MedPack? updatedMedpack;
    try {
      updatedMedpack = await dataProvider.updateMedpack(medpackId, tag);
    } catch (error) {
      print(error.toString());
      return null;
    }

    await localDataProvider.updateMedpack(medpackId, tag);
    return updatedMedpack;
  }

  Future<Pill?> addPill(
      int medpackId, String medicineName, int strength, int amount) async {
    Pill? newPill;

    try {
      newPill = await dataProvider.addNewPill(
          medpackId, medicineName, strength, amount);
    } catch (error) {
      print(error.toString());
      return null;
    }

    return newPill;
  }

  Future<void> removePill(int pillId) async {
    try {
      await dataProvider.removePill(pillId);
    } catch (error) {
      print(error.toString());
      return;
    }
    await localDataProvider.removePill(pillId);
  }

  Future<Pill?> updatePill(int pillId, int strength, int amount) async {
    Pill? updatedPill;
    try {
      updatedPill = await dataProvider.updatePill(pillId, strength, amount);
    } catch (error) {
      print(error.toString());
    }
    return updatedPill;
  }
}

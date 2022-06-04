import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
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

  Future<List<Pharmacy>?> searchMedicines(int medpackId) async {
    List<Pharmacy>? pharmacies = await dataProvider.searchMedicines(medpackId);
    return pharmacies;
  }

  Future<List<MedPack>?> getMedPacks() async {
    List<MedPack>? medpacks; //= await localDataProvider.getMedPacks();

    if (medpacks == null || medpacks.isEmpty) {
      medpacks = await dataProvider.getMedPacks();
      for (MedPack mp in medpacks as List<MedPack>) {
        // localDataProvider.addNewMedpack(mp.description,
        //     medpackId: mp.medpackId);
      }
    }
    return medpacks;
  }

  Future<MedPack?> addMedPack(String description) async {
    MedPack? newMedpack = MedPack({});

    try {
      newMedpack.setDescription(description);
    } catch (error) {
      rethrow;
    }

    try {
      newMedpack = await dataProvider.addNewMedpack(description);
    } catch (e) {
      print(e.toString());
      return null;
    }

    // await localDataProvider.addNewMedpack(description,
    //     medpackId: newMedpack!.medpackId);

    return newMedpack;
  }

  Future<void> removeMedPack(int medpackId) async {
    try {
      await dataProvider.removeMedpack(medpackId);
    } catch (error) {
      print(error.toString());
      return;
    }
    // await localDataProvider.removeMedpack(medpackId);
  }

  Future<MedPack?> updateMedpack(int medpackId, String tag) async {
    MedPack? updatedMedpack = MedPack({});

    try {
      updatedMedpack.setDescription(tag);
    } catch (error) {
      rethrow;
    }

    try {
      updatedMedpack = await dataProvider.updateMedpack(medpackId, tag);
    } catch (error) {
      print(error.toString());
      return null;
    }

    // await localDataProvider.updateMedpack(medpackId, tag);
    return updatedMedpack;
  }

  Future<Pill?> addPill(
      int medpackId, String medicineName, int strength, int amount) async {
    MedicineName medName = MedicineName(medicineName);
    Pill? newPill = Pill(0, medName, strength, amount);

    if (!newPill.validate()) {
      throw InvalidValueError();
    }

    try {
      newPill =
          await dataProvider.addNewPill(medpackId, medName, strength, amount);
    } catch (error) {
      print(error.toString());
      return null;
    }
    // await localDataProvider.addNewPill(medpackId, medName, strength, amount);

    return newPill;
  }

  Future<void> removePill(int medpackId, int pillId) async {
    try {
      await dataProvider.removePill(medpackId, pillId);
    } catch (error) {
      print(error.toString());
      return;
    }
    // await localDataProvider.removePill(pillId);
  }

  Future<Pill?> updatePill(int medpackId, int pillId, int strength, int amount) async {
    Pill? updatedPill =
        Pill(0, const MedicineName('validation'), strength, amount);

    if (!updatedPill.validate()) {
      throw InvalidValueError();
    }

    try {
      updatedPill = await dataProvider.updatePill(medpackId, pillId, strength, amount);
    } catch (error) {
      print(error.toString());
    }
    // await localDataProvider.updatePill(pillId, strength, amount);

    return updatedPill;
  }
}

import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/DataSource/remote_data_provider.dart';

abstract class WatchListRepository {
  Future<List<MedPack>?> getMedPacks();

  Future<MedPack?> addMedPack({required String description});

  Future<void> addPill(
      {required int medpackId,
      required String medicineName,
      required int strength,
      required int amount});
  Future<void> removePill({required int pillId});

  Future<void> removeMedPack({required int medpackId});
}

class HttpWatchListRepository implements WatchListRepository {
  final RemoteWatchListDataProvider dataProvider =
      RemoteWatchListDataProvider();

  @override
  Future<List<MedPack>?> getMedPacks() async {
    List<MedPack>? medpacks = await dataProvider.getMedPacks();
    return medpacks;
  }
  
  @override
  Future<MedPack?> addMedPack({required String description}) async {
    MedPack? newMedpack = await dataProvider.addNewMedpack(description);
    return newMedpack;
  }

  @override
  Future<void> removeMedPack({required int medpackId}) async {
    await dataProvider.removeMedpack(medpackId);
  }

  @override
  Future<void> addPill(
      {required int medpackId,
      required String medicineName,
      required int strength,
      required int amount}) async{}

  @override
  Future<void> removePill({required int pillId}) async{}
}

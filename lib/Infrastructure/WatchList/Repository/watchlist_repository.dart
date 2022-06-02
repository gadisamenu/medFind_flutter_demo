import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/DataSource/remote_data_provider.dart';

class WatchListRepository {
  final HttpRemoteWatchListDataProvider dataProvider =
      HttpRemoteWatchListDataProvider();

  Future<List<MedPack>?> getMedPacks() async {
    List<MedPack>? medpacks = await dataProvider.getMedPacks();
    return medpacks;
  }

  Future<MedPack?> addMedPack({required String description}) async {
    MedPack? newMedpack = await dataProvider.addNewMedpack(description);
    return newMedpack;
  }

  Future<void> removeMedPack({required int medpackId}) async {
    await dataProvider.removeMedpack(medpackId);
  }

  Future<void> addPill(
      {required int medpackId,
      required String medicineName,
      required int strength,
      required int amount}) async {}

  Future<void> removePill({required int pillId}) async {}
}

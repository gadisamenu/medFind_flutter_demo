import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Domain/WatchList/value_objects.dart';

abstract class WatchListDataProvider {
  Future<List<MedPack>?> getMedPacks();

  Future<MedPack?> addNewMedpack(String description, {int? medpackId});
  Future<void> removeMedpack(int medpackId);

  Future<MedPack?> updateMedpack(int medpackId, String tag);
  Future<Pill?> addNewPill(
      int medpackId, MedicineName name, int strength, int amount,{int? pillId});
  Future<void> removePill(int medpackId, int pillId);
  Future<Pill?> updatePill(int medpackId, int pillId, int strength, int amount);
}

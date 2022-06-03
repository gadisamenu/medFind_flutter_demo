import 'package:medfind_flutter/Domain/WatchList/medpack.dart';

class WatchList {
  Map<int, MedPack> medpacks = {};

  void addMedpack(MedPack newMedpack) {
    medpacks.putIfAbsent(newMedpack.medpackId, () => newMedpack);
  }

  Map<int, MedPack> getMedpack() => medpacks;

  void removeMedpack(int medpackId) {
    medpacks.remove(medpackId);
  }

  void addAllMedpacks(List<MedPack>? newMedpacks) {
    for (MedPack medpack in newMedpacks!) {
      medpacks.putIfAbsent(medpack.medpackId, () => medpack);
    }
  }
}

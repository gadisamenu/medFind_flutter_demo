import 'package:medfind_flutter/Domain/WatchList/medpack.dart';

class WatchList {
  List<MedPack> medpacks = [];

  // factory WatchList.fromJson(Map<String, dynamic> watchlistJson) {
  // return WatchList(watchlistJson['description']);
  // }
  void addMedpack(MedPack new_medpack) {
    medpacks.add(new_medpack);
  }

  void addAllMedpacks(List<MedPack>? newMedpacks) {
    medpacks.addAll(newMedpacks!);
  }
}

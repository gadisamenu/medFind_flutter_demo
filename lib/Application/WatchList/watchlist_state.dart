import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Domain/WatchList/watch_list.dart';


class WatchListState extends WatchList {

  void update(int medpackId, MedPack newMedpack) {
    medpacks.update(medpackId, (value) => newMedpack);
  }

  void addPillToMedpack(int medpackId, Pill newPill) {
    MedPack? updatedMedpack = medpacks[medpackId];
    updatedMedpack!.addPill(newPill);

    update(medpackId, updatedMedpack);
  }
}

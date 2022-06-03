import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Domain/WatchList/value_objects.dart';
import 'package:medfind_flutter/Domain/_Shared/common.dart';

class MedPack {
  late int medpackId;

  Map<int, Pill> pills = {};

  late String description;
  MedPack(this.pills);

  void setMedpackId(int medpackId) {
    this.medpackId = medpackId;
  }

  void setDescription(String description) {
    if (validateDescription(description)) {
      throw InvalidValueError();
    }
    this.description = description;
  }

  bool validateDescription(String description) {
    if (description.length < 200) {
      return true;
    }
    return false;
  }

  List<Pill> getPills() => pills.values.toList();

  void addPill(Pill newPill) {
    pills.putIfAbsent(newPill.pillId, () => newPill);
  }

  void updatePill(int pillId, String medicineName, int strength, int amount) {
    MedicineName medName = MedicineName(medicineName);
//
//
//
//
    pills[pillId]!.name = medName;
    pills[pillId]!.strength = strength;
    pills[pillId]!.amount = amount;
  }

  factory MedPack.fromJson(Map<String, dynamic> medpackJson) {
    List<dynamic> pillsData = medpackJson['pills'];
    Map<int, Pill> pills = {};
    for (dynamic pill in pillsData) {
      Pill parsedPill = Pill.fromJson(pill);
      pills.putIfAbsent(parsedPill.pillId, () => parsedPill);
    }
    MedPack parsedMedpack = MedPack(pills);
    parsedMedpack.setDescription(medpackJson['tag']);
    return parsedMedpack;
  }

  Map<String, Object> toJson() {
    List<String> pillMaps = [];
    for (Pill pill in pills.values) {
      pillMaps.add(pill.toJson().toString());
    }
    return {
      'id': medpackId,
      'pills': {pillMaps.toString()},
      'tag': description
    };
  }
}

import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Domain/WatchList/value_objects.dart';

class MedPack {
  late int medpackId;

  Map<int, Pill> pills = {};

  late String description;
  MedPack(this.description, this.pills);

  void setMedpackId(int medpackId) {
    this.medpackId = medpackId;
  }

  void setDescription(String description) {
    this.description = description;
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
    return MedPack(medpackJson['tag'], pills);
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

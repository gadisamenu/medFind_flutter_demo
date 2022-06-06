import 'package:equatable/equatable.dart';
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
    if (!validateDescription(description)) {
      throw InvalidValueError();
    }
    this.description = description;
  }

  bool validateDescription(String description) {
    if (description.length < 1000) {
      return true;
    }
    return false;
  }

  List<Pill> getPills() => pills.values.toList();

  void addPill(Pill newPill) {
    pills.putIfAbsent(newPill.pillId, () => newPill);
  }

  Pill removePill(int pillId) {
    return pills.remove(pillId)!;
  }

  void updatePill(int pillId, int strength, int amount) {
    pills[pillId]!.strength = strength;
    pills[pillId]!.amount = amount;
  }

  factory MedPack.fromJson(Map<String, dynamic> medpackJson) {
    int id = medpackJson['id'];
    // print(id);
    List<dynamic> pillsData = medpackJson['pills'];
    Map<int, Pill> pills = {};
    for (dynamic pill in pillsData) {
      Pill parsedPill = Pill.fromJson(pill);
      pills.putIfAbsent(parsedPill.pillId, () => parsedPill);
    }
    MedPack parsedMedpack = MedPack(pills);
    parsedMedpack.setDescription(medpackJson['tag']);
    parsedMedpack.setMedpackId(medpackJson['id']);
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

  @override
  bool operator ==(Object other) {
    return other is MedPack && other.medpackId == medpackId;
  }

  @override
  int get hashCode => Object.hash(medpackId, []);
}

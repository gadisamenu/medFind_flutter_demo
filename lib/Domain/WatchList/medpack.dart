import 'package:medfind_flutter/Domain/WatchList/pill.dart';

class MedPack {
  late int medpackId;

  List<Pill> pills = [];
  late String description;
  MedPack();

  void setMedpackId(int medpackId) {
    this.medpackId = medpackId;
  }

  void setDescription(String description) {
    this.description = description;
  }

  List<Pill> getPills() => pills;

  void addPill(Pill newPill) {
    pills.add(newPill);
  }

  void addAllPills(List<Pill> newPills) {
    pills.addAll(newPills);
  }

  factory MedPack.fromJson(String medpackJson) {
    return MedPack();
  }

  static Map<String, dynamic> toJson() {
    return <String, dynamic>{};
  }
}

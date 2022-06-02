import 'package:medfind_flutter/Domain/WatchList/pill.dart';

class MedPack {
  int medpackId;

  List<Pill> pills = [];
  String description;
  MedPack(this.medpackId, this.description);

  List<Pill> getPills() => pills;

  void addPill(Pill newPill) {
    pills.add(newPill);
  }

  void addAllPills(List<Pill> newPills) {
    pills.addAll(newPills);
  }

  // static MedPack fromJson(Map<String, String> medpackJson){

  // }
  // static Map<String, String> toJson(){
    
  // }
}

import 'package:flutter/material.dart';

abstract class WatchListEvent {}

class FetchMedpacks extends WatchListEvent {
  FetchMedpacks();
}

class SearchMedpack extends WatchListEvent {
  int medpackID;
  BuildContext context;
  SearchMedpack(this.medpackID, this.context);
}

class GetMedPacks extends WatchListEvent {}

class AddMedpack extends WatchListEvent {
  String description;

  AddMedpack(this.description);
}

class RemoveMedpack extends WatchListEvent {
  int medpackID;

  RemoveMedpack(this.medpackID);
}

class UpdateMedPackTag extends WatchListEvent {
  int medpackID;
  String newTag;

  UpdateMedPackTag(this.medpackID, this.newTag);
}

class AddPill extends WatchListEvent {
  int medpackID;
  String name;
  int strength;
  int amount;

  AddPill(this.medpackID, this.name, this.strength, this.amount);
}

class RemovePill extends WatchListEvent {
  int pillID;
  int medpackID;

  RemovePill(this.medpackID, this.pillID);
}

class UpdatePill extends WatchListEvent {
  int pillId;
  int medpackId;

  String medicineName;
  int strength;
  int amount;

  UpdatePill(this.pillId, this.medicineName, this.medpackId, this.strength, this.amount);
}

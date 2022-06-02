abstract class WatchListEvent {}

class FetchMedpacks extends WatchListEvent {
  FetchMedpacks();
}

class SearchMedpack extends WatchListEvent {
  int medpackID;

  SearchMedpack(this.medpackID);
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

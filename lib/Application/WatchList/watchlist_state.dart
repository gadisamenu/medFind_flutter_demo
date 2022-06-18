import 'package:medfind_flutter/Domain/WatchList/medpack.dart';

class State {
  static Map<int, MedPack> medpacks = {};

  State({List<MedPack>? medpacks}) {
    if (medpacks == null) {
    } else {
      for (MedPack mp in medpacks) {
        State.medpacks[mp.medpackId] = mp;
      }
    }
  }
}

class LoadingState implements State {
  String message;
  LoadingState(this.message) : super();
}

class NormalState extends State {
  NormalState({List<MedPack>? medpacks}) : super(medpacks: medpacks);
}

enum SuccessType {
  PILL_CREATED,
  PILL_UPDATED,
  PILL_REMOVED,
  MEDPACK_REMOVED,
  MEDPACK_ADDED,
  MEDPACK_TAG_MODIFIED
}

class SuccessState extends State {
  SuccessType type;
  String message;
  SuccessState(this.message, this.type, {List<MedPack>? medpacks})
      : super(medpacks: medpacks);
}

enum FailureType { PILL_FAILURE, MEDPACK_FAILURE, CONNECTION_FAILURE }

class FailureState extends State {
  String message;
  FailureType type;

  FailureState(this.message, this.type);
}

class NoMedPackState extends State {
  final message = "No medpacks in your watchlist";
  NoMedPackState() : super();
}

class DisconnectedState extends State {
  final message = "No internet connection";
  DisconnectedState();
}

import 'package:medfind_flutter/Domain/WatchList/medpack.dart';

class State {
  static Map<int, MedPack> medpacks={};

  State({List<MedPack>? medpacks}) {
    if (medpacks == null) {
      // State.medpacks = {};
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

class SuccessState extends State {
  String message;
  SuccessState(this.message, {List<MedPack>? medpacks})
      : super(medpacks: medpacks);
}

class FailureState extends State {
  String message;
  FailureState(this.message);
}

class NoMedPackState extends State {
  final message = "No medpacks in your watchlist";
  NoMedPackState() : super();
}

class DisconnectedState extends State {
  final message = "No internet connection";
  DisconnectedState();
}

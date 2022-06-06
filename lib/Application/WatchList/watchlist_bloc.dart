import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_event.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_state.dart';
import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Domain/_Shared/common.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/DataSource/_watchlist_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/Repository/watchlist_repository.dart';

class WatchListBloc extends Bloc<WatchListEvent, State> {
  final WatchListRepository wr = WatchListRepository();

  WatchListBloc() : super(NormalState()) {
    on<GetMedPacks>(_getMedpacks);

    on<AddMedpack>(_addMedpack);
    on<RemoveMedpack>(_removeMedpack);
    on<UpdateMedPackTag>(_updateMedpackTag);

    on<AddPill>(_addPill);
    on<RemovePill>(_removePill);
    on<UpdatePill>(_updatePill);

    on<SearchMedpack>(_searchMedpack);
  }

  Future<void> _getMedpacks(GetMedPacks event, Emitter emit) async {
    List<MedPack>? newMedpacks;
    emit(LoadingState("Getting medpacks"));
    try {
      newMedpacks = await wr.getMedPacks();
      print(newMedpacks);
    } on DisconnectedException catch (error) {
      emit(FailureState(error.message));
      print(error.message);
      return;
    } on NoElementFoundException {
      emit(NoMedPackState());
      return;
    }
    emit(NormalState(medpacks: newMedpacks));
    print('no element');
  }

  Future<void> _addMedpack(AddMedpack event, Emitter emit) async {
    MedPack? medpack;
    emit(LoadingState("Creating new medpack"));
    try {
      medpack = await wr.addMedPack(event.description);
    } on DisconnectedException catch (error) {
      emit(FailureState(error.message));
      return;
    } on InvalidValueException catch (error) {
      emit(FailureState(error.message));
      return;
    }

    State.medpacks[medpack!.medpackId] = medpack;

    emit(SuccessState(
        "Successfully created medpack", SuccessType.MEDPACK_ADDED));
  }

  Future<void> _removeMedpack(RemoveMedpack event, Emitter emit) async {
    emit(LoadingState("Removing medpack"));
    try {
      await wr.removeMedPack(event.medpackID);
    } on DisconnectedException catch (error) {
      emit(FailureState(error.message));
      return;
    }
    State.medpacks.remove(event.medpackID);
    emit(SuccessState(
        "Successfully removed medpack", SuccessType.MEDPACK_REMOVED));
  }

  Future<void> _updateMedpackTag(UpdateMedPackTag event, Emitter emit) async {
    MedPack? updatedMedpack;

    emit(LoadingState("Updating medpack"));
    try {
      updatedMedpack = await wr.updateMedpack(event.medpackID, event.newTag);
    } on DisconnectedException catch (error) {
      emit(FailureState(error.message));
      return;
    } on InvalidValueException catch (error) {
      emit(FailureState(error.message));
      return;
    }
    State.medpacks[event.medpackID] = updatedMedpack!;
    emit(SuccessState(
        "Successfully updated medpack tag", SuccessType.MEDPACK_TAG_MODIFIED));
  }

  Future<void> _addPill(AddPill event, Emitter emit) async {
    Pill? newPill;
    emit(LoadingState("Adding new pill"));
    try {
      newPill = await wr.addPill(
          event.medpackID, event.name, event.strength, event.amount);
    } on DisconnectedException catch (error) {
      emit(FailureState(error.message));
      return;
    } on InvalidValueException catch (error) {
      emit(FailureState(error.message));
      return;
    }
    State.medpacks[event.medpackID]?.addPill(newPill!);
    emit(SuccessState("Successfully added pill", SuccessType.PILL_CREATED));
  }

  Future<void> _removePill(RemovePill event, Emitter emit) async {
    emit(LoadingState("Removing pill"));
    try {
      await wr.removePill(event.medpackID, event.pillID);
    } on DisconnectedException catch (error) {
      emit(FailureState(error.message));
      return;
    }
    State.medpacks[event.medpackID]?.removePill(event.pillID);
    emit(SuccessState("Successfully removed pill", SuccessType.PILL_REMOVED));
  }

  Future<void> _searchMedpack(SearchMedpack event, Emitter emit) async {
    GoRouter.of(event.context).push('/search', extra: event.medpackID);
  }

  Future<void> _updatePill(UpdatePill event, Emitter emit) async {
    Pill? updatedPill;

    emit(LoadingState("Updating pill"));
    try {
      updatedPill = await wr.updatePill(
          event.medpackId, event.pillId, event.strength, event.amount);
    } on DisconnectedException catch (error) {
      emit(FailureState(error.message));
      return;
    } on InvalidValueException catch (error) {
      emit(FailureState(error.message));
      return;
    }
    State.medpacks[event.medpackId]!
        .updatePill(event.pillId, event.strength, event.amount);
    emit(SuccessState("Successfully updated pill", SuccessType.PILL_UPDATED));
  }
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_event.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_state.dart';
import 'package:medfind_flutter/Domain/MedicineSearch/pharmacy.dart';
import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/pill.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/Repository/watchlist_repository.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  final WatchListRepository wr = WatchListRepository();

  late WatchListState watchListState;

  WatchListBloc() : super(WatchListState()) {
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
    List<MedPack>? newMedpacks = await wr.getMedPacks();

    watchListState.addAllMedpacks(newMedpacks);

    emit(watchListState);
  }

  Future<void> _addMedpack(AddMedpack event, Emitter emit) async {
    MedPack? medpack = await wr.addMedPack(event.description);

    watchListState.addMedpack(medpack!);

    emit(watchListState);
  }

  Future<void> _removeMedpack(RemoveMedpack event, Emitter emit) async {
    await wr.removeMedPack(event.medpackID);

    watchListState.removeMedpack(event.medpackID);

    emit(watchListState);
  }

  Future<void> _updateMedpackTag(UpdateMedPackTag event, Emitter emit) async {
    MedPack? updatedMedpack =
        await wr.updateMedpack(event.medpackID, event.newTag);

    watchListState.update(event.medpackID, updatedMedpack!);

    emit(watchListState);
  }

  Future<void> _addPill(AddPill event, Emitter emit) async {
    
    Pill? newPill = await wr.addPill(
        event.medpackID, event.name, event.strength, event.amount);

    watchListState.addPillToMedpack(event.medpackID, newPill!);

    emit(watchListState);
  }

  Future<void> _removePill(RemovePill event, Emitter emit) async {
    await wr.removePill(event.pillID);

    watchListState.getMedpack().remove(event.pillID);

    emit(watchListState);
  }

  Future<void> _searchMedpack(SearchMedpack event, Emitter emit) async {
    List<Pharmacy>? pharmacies = await wr.searchMedicines(event.medpackID);
    GoRouter.of(event.context).push('/search_result', extra: pharmacies);
  }

  Future<void> _updatePill(UpdatePill event, Emitter emit) async {
    Pill? updatedPill =
        await wr.updatePill(event.pillId, event.strength, event.amount);
    watchListState.getMedpack().update(event.medpackId, (value) {
      value.updatePill(
          event.pillId, event.medicineName, event.strength, event.amount);
      return value;
    });
  }
}

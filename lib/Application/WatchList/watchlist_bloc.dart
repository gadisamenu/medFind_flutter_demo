import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_event.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_state.dart';
import 'package:medfind_flutter/Domain/WatchList/medpack.dart';
import 'package:medfind_flutter/Domain/WatchList/watch_list.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/Repository/watchlist_repository.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  final WatchListRepository wr = WatchListRepository();

  late WatchListState watchListState;

  WatchListBloc() : super(WatchListState()) {
    on<AddMedpack>(_addMedpack);
    on<RemoveMedpack>(_removeMedpack);
    on<AddPill>(_addPill);
    on<RemovePill>(_removePill);
    on<AddMedpack>(_addMedpack);

    on<SearchMedpack>(_searchMedpack);
    on<GetMedPacks>(_getMedpacks);
  }

  Future<void> _addMedpack(AddMedpack event, Emitter emit) async {
    MedPack? medpack = await wr.addMedPack(description: event.description);

    watchListState.getState().addMedpack(medpack!);

    emit(watchListState);
  }

  Future<void> _removeMedpack(RemoveMedpack event, Emitter emit) async {}
  Future<void> _addPill(AddPill event, Emitter emit) async {}
  Future<void> _removePill(RemovePill event, Emitter emit) async {}
  Future<void> _searchMedpack(SearchMedpack event, Emitter emit) async {}

  Future<void> _getMedpacks(GetMedPacks event, Emitter emit) async {
    List<MedPack>? medpacks = await wr.getMedPacks();
    WatchList newWatchlist = WatchList();
    newWatchlist.addAllMedpacks(medpacks);

    watchListState.setState(newWatchlist);

    emit(watchListState);
  }
}

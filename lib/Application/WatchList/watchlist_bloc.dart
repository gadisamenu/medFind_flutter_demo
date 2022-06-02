import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_event.dart';
import 'package:medfind_flutter/Application/WatchList/watchlist_state.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  WatchListBloc() : super(WatchListState()) {
    on<AddMedpack>(_addMedpack);
    on<RemoveMedpack>(_removeMedpack);
    on<AddPill>(_addPill);
    on<RemovePill>(_removePill);
    on<AddMedpack>(_addMedpack);

    on<SearchMedpack>(_searchMedpack);
    on<GetMedPacks>(_getMedpacks);
  }

  Future<void> _addMedpack(AddMedpack event, Emitter emit) async {}
  Future<void> _removeMedpack(RemoveMedpack event, Emitter emit) async {}
  Future<void> _addPill(AddPill event, Emitter emit) async {}
  Future<void> _removePill(RemovePill event, Emitter emit) async {}
  Future<void> _searchMedpack(SearchMedpack event, Emitter emit) async {}

  Future<void> _getMedpacks(GetMedPacks event, Emitter emit) async {}
}

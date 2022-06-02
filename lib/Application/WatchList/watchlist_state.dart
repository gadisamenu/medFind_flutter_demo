import 'package:medfind_flutter/Domain/WatchList/watch_list.dart';

class WatchListState {
  late WatchList watchListState;

  void setState(WatchList watchlist) {
    watchListState = watchlist;
  }

  WatchList getState() => watchListState;
  
}

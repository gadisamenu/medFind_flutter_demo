import 'package:bloc/bloc.dart';
import 'package:medfind_flutter/Application/Navigation/navigation_event.dart';
import 'package:medfind_flutter/Application/Navigation/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationLoaded(path: "/home")) {
    on(Navigate) => _Navigate;
  }

  void _Navigate(NavigationEvent event, Emitter emit) async {
    // emit(NavigationLoading());
    emit(NavigationLoaded(path: event.path));
  }
}

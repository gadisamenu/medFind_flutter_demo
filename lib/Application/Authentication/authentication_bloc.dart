import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_event.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_state.dart';

import '../../Infrastructure/Authentication/Repository/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;


  AuthenticationBloc({required this.userRepository})
      : super(AuthUninitialized()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        emit(Authenticated());
      } else {
        emit(UnAuthenticated());
      }
    });
    
    on<LoggedIn>((event, emit) async {
      emit(Authenticating());
      await userRepository.persistToken(event.token);
      emit(Authenticated());
    });

    on<LoggedOut>((event, emit) async {
      emit(Authenticating());
      await userRepository.deleteToken();
      emit(UnAuthenticated());
    });
  }
}

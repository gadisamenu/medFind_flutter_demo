import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_event.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_state.dart';
import 'package:medfind_flutter/Domain/Authentication/User.dart';

import '../../Infrastructure/Authentication/Repository/auth_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;

  AuthenticationBloc(this.authRepository) : super(AuthUninitialized()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await authRepository.hasToken();
      if (hasToken) {
        emit(Authenticated("USER"));
      } else {
        emit(UnAuthenticated());
      }
    });

    on<Login>((event, emit) async {
      emit(Authenticating());
      try {
        var token = await authRepository.authenticate(
            email: event.email, password: event.password);
        token = jsonDecode(token)["token"];
        await authRepository.persistToken(token);
        var user = await authRepository.getUser();
        emit(Authenticated(user.role));
      } catch (e) {
        emit(AuthenticationFailed());
      }
    });

    on<Logout>((event, emit) async {
      emit(Authenticating());
      await authRepository.deleteToken();
      emit(UnAuthenticated());
    });
    on<Signup>((event, emit) async {
      emit(SigningUp());
      try {
        await authRepository.signUp(User(
          event.firstName,
          event.lastName,
          event.email,
          event.password,
          event.role,
        ));
        emit(UnAuthenticated());
      } catch (e) {
        emit(SignUpFailed());
      }
    });
  }
}
